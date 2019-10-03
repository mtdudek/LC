module _1_bitadder(output s,c_out, input a,b,c_in);
  and (l1,a,b);
  xor (l2,a,b);
  and (l3,l2,c_in);
  xor (s,l2,c_in);
  or (c_out,l1,l3);
endmodule

module _4_bitadder(output [3:0] s, output c_out, input [3:0] a,b, input c_in);
  _1_bitadder fa0(s[0],c1,a[0],b[0],c_in);
  _1_bitadder fa1(s[1],c2,a[1],b[1],c1);
  _1_bitadder fa2(s[2],c3,a[2],b[2],c2);
  _1_bitadder fa3(s[3],c_out,a[3],b[3],c3);
endmodule

module _1_BCD_adder(output [3:0] s, output c_out, input [3:0] a,b, input c_in);
  logic [3:0] c1;
  logic [3:0] w1;
  _4_bitadder _4bit0(c1,c_o,a,b,c_in);
  and (t0,c1[3],c1[2]);
  and (t1,c1[3],c1[1]);
  or (t2,c_o,t0);
  or (c_out,t1,t2);
  assign w1={1'b0,c_out,c_out,1'b0};
  _4_bitadder _4bit1(s,q,c1,w1,0);
endmodule

module _9s_com(output [3:0] s,input [3:0] a, input M);
  xor (s[0],a[0],M);
  assign s[1]=a[1];
  not (t,M);
  xor (t0,a[1],a[2]);
  and (t1,t0,M);
  and (t2,a[2],t);
  or (s[2],t1,t2);
  and (t3,a[3],t);
  and (t4,~a[1],~a[2]);
  and (t5,M,~a[3]);
  and (t6,t4,t5);
  or (s[3],t3,t6);
endmodule 

module _1_BCD_add_sub_first (output [3:0] s, output c_out, input [3:0] a,b, input M);
  logic [3:0] x;
  _9s_com sub_part(x,b,M);
  _1_BCD_adder add(s,c_out,a,x,M);
endmodule 
  
module _1_BCD_add_sub(output [3:0] s, output c_out, input [3:0] a,b, input c_in, M);
  logic [3:0] x;
  _9s_com sub_part(x,b,M);
  _1_BCD_adder add(s,c_out,a,x,c_in);
endmodule 

module _2_BCD_add_sub (output [7:0] o,input [7:0] a,b, input sub);
  logic [3:0] a0,a1,b0,b1,c0,c1;
  assign {a1,a0} = a;
  assign {b1,b0} = b;
  _1_BCD_add_sub_first BCD0(c0,c_o0,a0,b0,sub);
  _1_BCD_add_sub BCD1(c1,q,a1,b1,c_o0,sub);
  assign o = {c1,c0};
endmodule

