module and_or_xor( input a,b,output p,g,x);
  or P(p,a,b);
  and G(g,a,b);
  xor X(x,a,b);
endmodule

module _4_input_fast_carry(input [3:0] p,g,input c_in, output [3:0] c_out, output PG,GG);
  logic c1,c2,c3,c4;
  assign c1 = g[0] | c_in & p[0];
  assign c2 = g[1] | g[0] & p[1] | c_in & p[0] & p[1];
  assign c3 = g[2] | g[1] & p[2] | g[0] & p[1] & p[2] | c_in & p[0] & p[1] & p[2];
  assign c4 = 	g[3] | 
    (g[2] & p[3]) | 
    (g[1] & p[2] & p[3]) | 
    (g[0] & p[1] & p[2] & p[3])|
    (c_in & p[0] & p[1] & p[2] & p[3]);
  assign PG = p[0] & p[1] & p[2] & p[3];
  assign GG = 	g[3] | 
    (g[2] & p[3]) | 
    (g[1] & p[2] & p[3]) | 
    (g[0] & p[1] & p[2] & p[3]);
  assign c_out = {c4,c3,c2,c1};
endmodule

module _4_bit_fast_adder(input [3:0] a,b,input c_in, output [3:0] s,output PG,GG);
  logic [3:0] p,g,x;
  genvar i,j;
  for (i=0;i<4;i=i+1)
    and_or_xor me(a[i],b[i],p[i],g[i],x[i]);
  logic [3:0] f_c;
  _4_input_fast_carry CLA(p,g,c_in,f_c,PG,GG);
  logic [4:0] carry;
  assign  carry = {f_c,c_in};
  for (j=0;j<4;j=j+1)
    xor(s[j],x[j],carry[j]);
endmodule

module _16_bit_fast_adder(input [15:0] a,b,output [15:0] o);
  logic [3:0] 	a0,a1,a2,a3,
  				b0,b1,b2,b3,
  				o0,o1,o2,o3;
  assign a = {a3,a2,a1,a0};
  assign b = {b3,b2,b1,b0};
  logic [3:0] p,g,f_c;
  logic d,c;
  _4_bit_fast_adder ad1(a0,b0,1'b0,o0,p[0],g[0]);
  _4_bit_fast_adder ad2(a1,b1,f_c[0],o1,p[1],g[1]);
  _4_bit_fast_adder ad3(a2,b2,f_c[1],o2,p[2],g[2]);
  _4_bit_fast_adder ad4(a3,b3,f_c[2],o3,p[3],g[3]);
  _4_input_fast_carry fc(p,g,1'b0,f_c,d,c);
  assign o = {o3,o2,o1,o0};
endmodule

