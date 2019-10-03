module memory(input wr, step, input [9:0] addr, input signed [15:0] in, output signed [15:0] out);
  logic signed [15:0] mem [0:1023];
  assign out = mem[addr-1];
  always_ff @(posedge step)
    if (wr) begin
      if(addr > 0)
      	mem[addr] <= in;
    end
endmodule

module register16(input signed [15:0] in, input nrst,write,step, output signed [15:0]out);
  always_ff @(posedge step or negedge nrst ) 
    if(!nrst)
      out <= 16'sh0000;
    else if(write)
      out <= in;
endmodule

module register10(input nrst,write,read,step, output [9:0]out);
  always_ff @(posedge step or negedge nrst ) begin
    if(!nrst)
      out <= 0;
  	else if(write) begin
      if (out < 1023)
        out <= out + 1;
  	end
  	else if(read) begin
      if(out > 0)
        out <= out - 1;
  	end
  end
endmodule

module CU(input push, input [1:0] op_i, output load_reg,cnt_inc,cnt_dec, output [1:0] op_o);
  always_comb begin
    load_reg = 0;
    cnt_inc = 0;
    cnt_dec = 0;
    if(push) begin
      load_reg = 1;
      cnt_inc = 1;
      op_o = 0;
    end
    else begin
      op_o = op_i;
      if( op_i > 0)
        load_reg = 1;
      if (op_i > 1 )
        cnt_dec = 1;
    end
  end
endmodule

module AU(input [1:0] op, input signed [15:0] a,b, output [15:0] o);
  always_comb begin
    if (op == 1)
      o = - a;
    else if (op == 2)
      o = a + b;
    else if (op == 3)
      o = a * b;
  end
endmodule

module test(input nrst,step,push,input [1:0] op, input signed [15:0] d, output [9:0] cnt, output signed [15:0] out);
  logic load_reg,cnt_inc,cnt_dec;
  logic [1:0] in_op;
  logic signed [15:0] res,ins,mem;
  CU controlunit(push,op,load_reg,cnt_inc,cnt_dec,in_op);
  AU arithmunit(in_op,out,mem,res);
  assign ins = push ? d : res;
  register16 stacktop(ins,nrst,load_reg,step,out);
  register10 counter(nrst,cnt_inc,cnt_dec,step,cnt);
  memory ram(push,step,cnt,out,mem);
endmodule