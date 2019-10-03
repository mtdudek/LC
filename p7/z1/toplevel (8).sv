module PWM_in(input clk, input [15:0]d, input [1:0] sel,
              output [15:0] cnt,cmp,top, output out);
  always_ff @ (posedge clk ) begin
    cnt <= cnt +1;
    t <= 3'b000;
    casez (t)
      3'b111 : begin
        if (cnt >= top) begin
          cnt <= 0 ;
          out <= 1;
        end
        else if (cnt >= cmp)
          out <=0;
      end
      default : ;
    endcase
      
    case (sel)
      1 : begin
        t <= t | 3'b001;
        cmp <= d;
      end
      2 : begin
        t <= t | 3'b010;
        top <= d;
      end
      3 : begin
        t <= t | 3'b100;
        cnt <= d;
      end
      0 : begin;
    endcase
  end
endmodule