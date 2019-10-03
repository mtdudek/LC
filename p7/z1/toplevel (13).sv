module PWM_in(input clk, input [15:0]d, input [1:0] sel,
           output [15:0] cnt,cmp,top, output out);
  always_ff @ (posedge clk ) begin
      if (cnt >= top) begin
        cnt <= 0;
        out <= 1;
      end
      else if (cnt >= cmp)
        out <= 0;
      cnt <= cnt + 1;
      case (sel)
        1 : cmp <= d;
        2 : top <= d;
        3 : cnt <= d;
        default : ;
      endcase
    end
endmodule