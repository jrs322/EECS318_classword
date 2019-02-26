module serial_port(RXDATA, bit_out, SSPCLK_OUT, OE_B, S_OUT,
                  TXDATA, bit_in, SSPCLK_IN, S_IN, CLEAR);
    input bit_in, SSPCLK_IN, S_IN, CLEAR;
    input[7:0] TXDATA;
    output bit_out, SSPCLK_OUT, OE_B, S_OUT;
    output[7:0] RXDATA;
    assign SSPCLK_OUT = SSPCLK_IN;
    reg[7:0] receive_value, transmit_value, RXDATA;
    reg S_OUT, sending, receiving, bit_out, bit_in;
    reg[2:0] out_count, in_count;
    initial
    begin
      {receive_value, transmit_value} <= 16'b0;
      out_count <= 3'b0;
      in_count <= 3'b0;
    end
    always @ (posedge SSPCLK_IN) //do transmit logic here
    begin
      if (CLEAR)
        begin
          receive_value <= 8'b0;
          bit_out <= 1'b0;
          out_count <= 3'b0;
          in_count <= 3'b0;
        end
      else
        if((transmit_value != TXDATA) & !sending)
        begin
            S_OUT <= 1'b1;
            transmit_value <= TXDATA;
            sending <= 1'b1;
        end
        else if(sending)
        begin
          case(out_count)
            3'b000:
              begin
                bit_out = transmit_value[out_count];
                out_count = out_count + 1;
              end
            3'b001:
            begin
              bit_out = transmit_value[out_count];
              out_count = out_count + 1;
            end
            3'b010:
            begin
              bit_out = transmit_value[out_count];
              out_count = out_count + 1;
            end
            3'b011:
            begin
              bit_out = transmit_value[out_count];
              out_count = out_count + 1;
            end
            3'b100:
            begin
              bit_out = transmit_value[out_count];
              out_count = out_count + 1;
            end
            3'b101:
            begin
              bit_out = transmit_value[out_count];
              out_count = out_count + 1;
            end
            3'b110:
            begin
              bit_out = transmit_value[out_count];
              out_count = out_count + 1;
            end
            3'b111:
              begin
                bit_out = transmit_value[out_count];
                out_count = 3'b0;
                sending <= 1'b0;
                S_OUT <= 1'b1;
              end
            default: $display("Outcount is incorrect")
          endcase
          else
            S_OUT <= 1'b0;
        end
    end
    always @ (posedge SSPCLK_IN) //do Receive logic here
    begin
      if(CLEAR)
        begin
          transmit_value <= 8'b0;
          bit_in <= 1'b0;
        end
      else
        if(S_IN)
          begin
            receiving <= 1'b1;
          end
        else if(receiving & S_IN)
          begin
            case(in_count)
              3'b000:
                begin
                  receive_value[7-in_count] = bit_in;
                  in_count = in_count + 1;
                end
              3'b001:
              begin
                receive_value[7-in_count] = bit_in;
                in_count = in_count + 1;
              end
              3'b010:
              begin
                receive_value[7-in_count] = bit_in;
                in_count = in_count + 1;
              end
              3'b011:
              begin
                receive_value[7-in_count] = bit_in;
                in_count = in_count + 1;
              end
              3'b100:
              begin
                receive_value[7-in_count] = bit_in;
                in_count = in_count + 1;
              end
              3'b101:
              begin
                receive_value[7-in_count] = bit_in;
                in_count = in_count + 1;
              end
              3'b110:
              begin
                receive_value[7-in_count] = bit_in;
                in_count = in_count + 1;
              end
              3'b111:
              begin
                receive_value[7-in_count] = bit_in;
                in_count = in_count + 1;
                receiving = 1'b0;
                RXDATA = receive_value;
              end
              default: $display("Incount is incorrect")
            endcase
          end
    end
    initial begin
      $monitor("%b %b %b %b %b %b", bit_in, bit_out, receive_value, stored_value, TXDATA, RXDATA);
    end
endmodule
