
// HC1 = hearts
// HC2 = diamonds
// HC3 = spades
// HC4 = clubs
//[0:12] hearts
//[13:25] diamonds
//[26:38] spades
//[39:51] clubs

module FreeCell (win , source, dest, clk);
  input[3:0] source, dest;
  input clk;
  output win;
  reg illegal;
  reg win_check;
  reg [0:51] c1 [0:12];
  reg [0:51] c2 [0:12];
  reg [0:51] c3 [0:12];
  reg [0:51] c4 [0:12];
  reg [0:51] c5 [0:12];
  reg [0:51] c6 [0:12];
  reg [0:51] c7 [0:12];
  reg [0:51] c8 [0:12];
  reg [0:51] fca;
  reg [0:51] fcb;
  reg [0:51] fcc;
  reg [0:51] fcd;
  reg [0:51] hc1;
  reg [0:51] hc2;
  reg [0:51] hc3;
  reg [0:51] hc4;

  //mover reg
  reg[0:51] temp;
  reg[0:51] check;
  integer i;

    assign win = ((hc1[12] == 1'b1) && (hc2[25] == 1'b1) && (hc3[38] == 1'b1) && (hc4[51] == 1'b1));

  initial
    begin
      //zero the board state
      illegal <= 1'b0;



      for (i = 0; i < 14; i = i + 1)
        begin
          c1[i] <= 52'b0;
          c2[i] <= 52'b0;
          c3[i] <= 52'b0;
          c4[i] <= 52'b0;
        end
      for (i = 0; i < 14; i = i + 1)
        begin
	        c5[i] = 52'b0;
          c6[i] = 52'b0;
          c7[i] = 52'b0;
          c8[i] = 52'b0;
        end
      fca <= 52'b0;
      fcb <= 52'b0;
      fcc <= 52'b0;
      fcd <= 52'b0;
      hc1[i] <= 52'b0;
      hc2[i] <= 52'b0;
      hc3[i] <= 52'b0;
      hc4[i] <= 52'b0;

      //zero the board state end
      //begin declaring column state
        //declaring c1
	c1[0][29] <= 1'b1;
	c1[1][23] <= 1'b1;
	c1[2][22] <= 1'b1;
	c1[3][18] <= 1'b1;
	c1[4][28] <= 1'b1;
	c1[5][13] <= 1'b1;
	c1[6][0] <= 1'b1;
	// end declaring c1
	// declaring c2
	c2[0][30] <= 1'b1;
	c2[1][35] <= 1'b1;
	c2[2][7] <= 1'b1;
	c2[3][42] <= 1'b1;
	c2[4][5] <= 1'b1;
	c2[5][12] <= 1'b1;
	c2[6][1] <= 1'b1;
	// end declaring c2
	// declaring c3
	c3[0][36] <= 1'b1;
	c3[1][45] <= 1'b1;
	c3[2][47] <= 1'b1;
	c3[3][44] <= 1'b1;
	c3[4][40] <= 1'b1;
	c3[5][38] <= 1'b1;
	c3[6][39] <= 1'b1;
	// end declaring c3
	// declaring c4
	c4[0][3] <= 1'b1;
	c4[1][26] <= 1'b1;
	c4[2][50] <= 1'b1;
	c4[3][43] <= 1'b1;
	c4[4][32] <= 1'b1;
	c4[5][8] <= 1'b1;
	c4[6][33] <= 1'b1;
	// end declaring c4
        // declaring c5
	c5[0][24] <= 1'b1;
	c5[1][10] <= 1'b1;
	c5[2][37] <= 1'b1;
	c5[3][31] <= 1'b1;
	c5[4][14] <= 1'b1;
	c5[5][34] <= 1'b1;
	// end declaring c5
	// declaring c6
	c6[0][17] <= 1'b1;
	c6[1][25] <= 1'b1;
	c6[2][41] <= 1'b1;
	c6[3][21] <= 1'b1;
	c6[4][2] <= 1'b1;
	c6[5][27] <= 1'b1;
	// end declaring c6
	// declaring c7
	c7[0][4] <= 1'b1;
	c7[1][15] <= 1'b1;
	c7[2][11] <= 1'b1;
	c7[3][19] <= 1'b1;
	c7[4][51] <= 1'b1;
	c7[5][48] <= 1'b1;
	// end declaring c7
	// declaring c8
	c8[0][49] <= 1'b1;
	c8[1][16] <= 1'b1;
	c8[2][9] <= 1'b1;
	c8[3][46] <= 1'b1;
	c8[4][6] <= 1'b1;
	c8[5][20] <= 1'b1;
	// end declaring c8
      //end declaring column state
end

  always @ (posedge clk )
    begin
      //begin source block, sets temp = to source and clears source
      if (source[3] == 1'b0) //source = columns
        begin
          case(source[2:0])
            3'b000:
              begin

                i = 12;
                while(c1[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c1[i];
                c1[i] <= 52'b0;

              end
            3'b001:
              begin

                i = 12;
                while(c2[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c2[i];
                c2[i] <= 52'b0;

              end
            3'b010:
              begin

                i = 12;
                while(c3[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c3[i];
                c3[i] <= 52'b0;

              end
            3'b011:
              begin

                i = 12;
                while(c4[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c4[i];
                c4[i] <= 52'b0;

              end
            3'b100:
              begin

                i = 12;
                while(c5[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c5[i];
                c5[i] <= 52'b0;

              end
            3'b101:
              begin
                i = 12;
                while(c6[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c6[i];
                c6[i] <= 52'b0;

              end
            3'b110:
              begin

                i = 12;
                while(c7[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c7[i];
                c7[i] <= 52'b0;

              end
            3'b111:
              begin

                i = 12;
                while(c8[i] == 52'b0 && i > 0)
                  begin
                    i = i - 1;
                  end
                temp <= c8[i];
                c8[i] <= 52'b0;

              end
            default: illegal <= 1'b1;
          endcase
        end

      if (source[3:2] == 2'b10) // source = freecell
        begin
          case(source[1:0])
            2'b00:
              begin
                if ( fca != 52'b0)
                  begin
                    temp <=  fca;
                    fca <= 52'b0;
                  end
                else
                  illegal <= 1'b1;
              end
            2'b01:
              begin
                if ( fcb != 52'b0)
                  begin
                    temp <=  fcb;
                    fcb <= 52'b0;
                  end
                else
                  illegal <= 1'b1;
              end
            2'b10:
              begin
                if ( fcc != 52'b0)
                  begin
                    temp <=  fcc;
                    fcc <= 52'b0;
                  end
                else
                  illegal <= 1'b1;
              end
            2'b11:
              begin
                if ( fcd != 52'b0)
                  begin
                    temp <=  fcd;
                    fcd <= 52'b0;
                  end
                else
                  illegal <= 1'b1;
              end
            default: illegal <= 1'b1;
          endcase
        end
      else
        illegal <= 1'b1; //illegal move
      // end source block

      //begin dest block
      if(~illegal) begin
        if(dest[3] == 1'b0) // dest is column
          begin
            case(dest[2:0])
              3'b000:
                begin
                  if(c1[12] == 52'b0)
                    begin
                      i = 12;
                      while (c1[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                      if(c1[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                        c1[i+1] <= temp;
                      else
                        illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
              3'b001:
                begin
                  if(c2[12] == 52'b0)
                    begin
                      i = 12;
                      while (c2[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                        if(c2[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                          c2[i+1] <= temp;
                        else
                          illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
              3'b010:
                begin
                  if(c3[12] == 52'b0)
                    begin
                      i = 12;
                      while (c3[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                        if(c3[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                          c3[i+1] <= temp;
                        else
                          illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
              3'b011:
                begin
                  if(c4[12] == 52'b0)
                    begin
                      i = 12;
                      while (c4[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                        if(c4[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                          c4[i+1] <= temp;
                        else
                          illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
              3'b100:
                begin
                  if(c5[12] == 52'b0)
                    begin
                      i = 12;
                      while (c5[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                      if(c5[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                        c5[i+1] <= temp;
                      else
                        illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
              3'b101:
                begin
                  if(c6[12] == 52'b0)
                    begin
                      i = 12;
                      while (c6[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                        if(c6[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                          c6[i+1] <= temp;
                        else
                          illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
              3'b110:
                begin
                  if(c7[12] == 52'b0)
                    begin
                      i = 12;
                      while (c7[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                        if(c7[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                          c7[i+1] <= temp;
                        else
                          illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
              3'b111:
                begin
                  if(c8[12] == 52'b0)
                    begin
                      i = 12;
                      while (c8[i] == 52'b0 && i >= 0)
                        begin
                          i = i - 1;
                        end
                        if(c8[i+1] == ((temp >>> 14) | (temp <<< 14) | (temp <<< 28) | (temp >>> 28) | (temp >>> 44) | temp <<< 44)) //check for legal placement
                          c8[i+1] <= temp;
                        else
                          illegal <= 1'b1;
                    end
                  else
                    illegal <= 1'b1;
                end
            endcase
          end
        if(dest[3:2] == 2'b10 && ~illegal)
          begin
            case(dest[1:0])
              2'b00:
                begin
                  if(fca == 52'b0)
                     fca <= temp;
                  else
                    illegal <= 1'b1;
                end
              2'b01:
                begin
                  if( fcb == 52'b0)
                     fcb <= temp;
                  else
                    illegal <= 1'b1;
                end
              2'b10:
                begin
                  if( fcc == 52'b0)
                     fcc <= temp;
                  else
                    illegal <= 1'b1;
                end
              2'b11:
                begin
                  if( fcd == 52'b0)
                     fcd <= temp;
                  else
                    illegal <= 1'b1;
                end
            endcase
          end
        if(dest[3:2] == 2'b11 && ~illegal) //dest is homecell
          begin
            case(dest[1:0])
              2'b00: //
                begin
                  if(hc1[0] == 52'b0 && temp[0] == 1'b1)
                    begin
                      hc1[0] <= temp;
                    end
                  else
                    begin
                      i = 1;
                      while(hc1[i] != 52'b0)
                        i = i + 1;
                      check <= hc1[i] >>> 1;
                      if (check == temp)
                        hc1[i] <= temp;
                      else
                        illegal <= 1'b1;
                    end
                end
              2'b01:
                begin

                  if(hc2[0] == 52'b0 && temp[14] == 1'b1)
                    begin
                      hc1[0] <= temp;
                    end
                  else
                    begin
                      i = 1;
                      while(hc2[i] != 52'b0)
                        i = i + 1;
                      check <= hc2[i] >>> 1;
                      if (check == temp)
                        hc2[i] <= temp;
                      else
                        illegal <= 1'b1;
                    end

                end
              2'b10:
                begin

                  if(hc3[0] == 52'b0 && temp[28] == 1'b1)
                    begin
                      hc3[0] <= temp;
                    end
                  else
                    begin
                      i = 1;
                      while(hc3[i] != 52'b0)
                        i = i + 1;
                      check <= hc3[i] >>> 1;
                      if (check == temp)
                        hc3[i] <= temp;
                      else
                        illegal <= 1'b1;
                    end

                end
              2'b11:
                begin
                  if(hc4[0] == 52'b0 && temp[39] == 1'b1)
                    begin
                      hc4[0] <= temp;
                    end
                  else
                    begin
                      i = 0;
                      while(hc4[i] != 52'b0)
                        i = i + 1;
                      check <= hc4[i] >>> 1;
                      if (check == temp)
                        hc4[i] <= temp;
                      else
                        illegal <= 1'b1;
                    end

                end
              default: illegal <= 1'b1;
            endcase
          end
      end // end illegal check
      //check for complete


    end

    initial begin
      $monitor("hc1 = %h, hc2 = %h, hc3 = %h, hc4 = %h, temp = %h \n", hc1[0:12], hc2[13:25], hc3[26:38], hc4[39:51], temp); 
    end

endmodule
