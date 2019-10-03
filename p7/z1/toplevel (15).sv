module PWM_in(input clk, input [15:0]d, input [1:0] sel,
           output [15:0] cnt,cmp,top, output out);
  always_ff @ (posedge clk ) begin
	  if (sel == 1)
		cmp <= d;
	  
	  if (sel == 2)
		top <= d;
		
	  if (sel == 3)
	    cnt <= d;
	  else if (cnt >= top)
	    cnt <= 0;
	  else 
	    cnt <= cnt + 1;
      if (cnt >= cmp)
        out <= 0;
	  else 
	    out <= 1;
    end
endmodule