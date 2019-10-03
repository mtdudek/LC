// Write your modules here!
module microwave(input clk,nrst,door,start,finish, output heat,light,bell);
  logic[2:0] state;
  logic q;
  always_ff@(posedge clk or negedge nrst) begin
    if (!nrst) begin
      state = 0;
    end else if(state == 0) begin
      if (start & !door) begin
      	state = 1;
      end else if (door) begin
        state = 3;
      end
    end else if(state == 1) begin
      if (door) begin
        state = 2;
      end else if (finish & !door) begin
      	state = 4;
      end
    end else if(state == 2) begin
      if (!door) begin
        state = 1;
      end
    end else if(state == 3) begin
      if(!door) begin
        state = 0;
      end
    end else if(state == 4) begin
      if (door) begin
        state = 3;
      end
    end
  end
  assign light = state[1] | state[0] ? 1'b1 : 1'b0;
  assign q = state[1] ? 1'b0 : state[0];
  assign heat = q ? 1'b1 : 1'b0;
  assign bell = state[2] ? 1'b1 : 1'b0;
endmodule
