module _2_x_4_bit_sort (input [7:0]a, output [7:0] o);
  assign o = a[0+:4] < a[4+:4] ? a: {a[0+:4],a[4+:4]};
endmodule

module _4_x_4_bit_sort (input [15:0]i,output [15:0]o);
  logic [3:0] a,b,c,d;
  logic [7:0] x0,x1;
  _2_x_4_bit_sort s0(i[8+:8],x0);
  _2_x_4_bit_sort s1(i[0+:8],x1);
  assign {a,b}=x0;
  assign {c,d}=x1;
  assign o = c < a ? (c < b ? {x0,x1} : 
                   (d < b ? {a,c,b,d} : {a,x1,b} )):
    			  (d < a ? (d < b ? {c,x0,d} : {c,a,d,b}):
                   {x1,x0});
endmodule