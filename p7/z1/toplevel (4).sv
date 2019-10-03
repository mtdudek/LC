module PWM_in(input clk, input [15:0]d, input [1:0] sel,
           output [15:0] cnt,cmp,top, output out);
  always_ff @ (posedge clk ) begin
      cnt <= cnt + 1'b1;
      if (cnt >= top) begin
        cnt <= 0;
        out <= 1;
      end
      else if (cnt >= cmp)
        out <= 0;
      case (sel)
        2'b01 : cmp <= d;
        2'b10 : top <= d;
        2'b11 : cnt <= d;
        default : ;
      endcase
    end
  end
endmodule