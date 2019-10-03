module PWM_in(input clk, input [15:0]d, input [1:0] sel,
              output [15:0] cnt,cmp,top, output out);
  always_ff @ (posedge clk ) begin
    cnt <= cnt + 1;
    t <= 0;
    case (t)
      7 : begin
        if (cnt >= top) begin
          cnt <= 0 ;
          out <= 1;
        end
        else if (cnt >= cmp)
          out <= 0;
      end
      default : ;
    endcase
      
    case (sel)
      1 : begin
        t <= {t[2],t[1],1'b1};
        cmp <= d;
      end
      2 : begin
        t <= {t[2],1'b1,t[0]};
        top <= d;
      end
      3 : begin
        t <= {1'b1,t[1],t[0]};
        cnt <= d;
      end
      0 : ;
    endcase
  end
endmodule