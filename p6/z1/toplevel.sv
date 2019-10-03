module Dswitch(input c,d,output q,nq);
  logic nr, ns;
  nand  gq(q, nr, nq), gnq(nq, ns, q),
  		gr(nr, d, c), gs(ns, nr, c);
endmodule

module DFF(input c,d,output q, nq);
  logic q1;
  Dswitch dl1(!c,d,q1, ,), dl2(c,q1,q, nq);
endmodule

module _1bitShiftRegister(input il,ic,ir,c,l,r, output q);
  logic en,lor,w;
  or(lor,r,l);
  and (en,lor,c);
  assign w = l ? ( r ? ic : il) : ir;
  DFF re(en,w,q,);
endmodule

module _2bitShiftRegister(input [1:0] ic,input il,ir,c,l,r, output [1:0]q);
  _1bitShiftRegister re0(q[1],ic[0],ir,c,l,r,q[0]);
  _1bitShiftRegister re1(il,ic[1],q[0],c,l,r,q[1]);
endmodule

module _4bitShiftRegister(input [3:0] ic,input il,ir,c,l,r, output [3:0]q);
  _2bitShiftRegister re0(ic[0+:2],q[2],ir,c,l,r,q[0+:2]);
  _2bitShiftRegister re1(ic[2+:2],il,q[1],c,l,r,q[2+:2]);
endmodule

module _8bitShiftRegister(input [7:0] ic,input il,ir,c,l,r, output [7:0]q);
  _4bitShiftRegister re0(ic[0+:4],q[4],ir,c,l,r,q[0+:4]);
  _4bitShiftRegister re1(ic[4+:4],il,q[3],c,l,r,q[4+:4]);
endmodule

module ShiftRegister(input [7:0]d,input i,c,l,r, output [7:0] q);
  _8bitShiftRegister re(d,i,i,c,l,r,q);
endmodule
