module PWM_in(input clk, input [15:0]d, input [1:0] sel,
           output [15:0] cnt,cmp,top, output out);
  always_ff @ (posedge clk ) begin
      case (sel)
        1 : begin
          cmp <= d;
          cnt <= cnt + 1;
        end
        2 : begin
          top <= d;
          cnt <= cnt + 1;
        end
        3 : cnt <= d;
        default : begin
          if (cnt >= top) begin
            cnt <= 0;
            out <= 1;
          end
          else if (cnt >= cmp)
            out <= 0;
        end
      endcase
    end
endmodule