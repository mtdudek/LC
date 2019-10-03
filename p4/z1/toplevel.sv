module _4_bit_one_shifter_left(input [3:0]i,input l, output [3:0] o);
  and(o[0],l,1'b0);
  and(o[1],l,i[0]);
  and(o[2],l,i[1]); 
  and(o[3],l,i[2]);
endmodule

module _4_bit_one_shifter_right(input [3:0]i,input r, output [3:0] o);
  and(o[0],r,i[1]);
  and(o[1],r,i[2]);
  and(o[2],r,i[3]); 
  and(o[3],r,1'b0);
endmodule

module _4_bit_and_with_1_bit (input [3:0]i,input n, output [3:0] o);
  and(o[0],n,i[0]);
  and(o[1],n,i[1]);
  and(o[2],n,i[2]); 
  and(o[3],n,i[3]);
endmodule

module _4_bit_or(input [3:0]i1, i2, output [3:0] o);
  or(o[0],i1[0],i2[0]);
  or(o[1],i1[1],i2[1]);
  or(o[2],i1[2],i2[2]);
  or(o[3],i1[3],i2[3]);
endmodule

module _4_bit_one_shifter(input [3:0]i,input r,l,output [3:0] o);
  logic n;
  logic [3:0] b,x1,x2,t;
  nor(n,r,l);
  _4_bit_and_with_1_bit ns(i,n,b);
  _4_bit_one_shifter_left sl(i,l,x1);
  _4_bit_one_shifter_right sr(i,r,x2);
  _4_bit_or o1(x1,x2,t);
  _4_bit_or o2(t,b,o);
endmodule