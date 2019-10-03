
module funnel_shifter(input [7:0]a,b, input [3:0] n,output [7:0] o);
  logic [15:0] l1,l2,l3,l4;
  assign l1 = n[0] ? {1'b0, a , b[1+:7] } : {a,b};
  assign l2 = n[1] ? {2'b0, l1[2+:14] } : l1;
  assign l3 = n[2] ? {4'b0, l2[4+:12] } : l2;
  assign l4 = n[3] ? {8'b0, l3[8+:8] } : l3;
  assign o = l4[0+:8];
endmodule

module arimetric(input [7:0] a,output [7:0]b);
  assign b={a[7],a[7],a[7],a[7],a[7],a[7],a[7],a[7]};
endmodule

module _to_8(input [3:0] a,output [3:0]b);
  assign b[0]=a[0];
  assign b[1]=!a[0]&a[1]|a[0]&!a[1];
  assign b[2]=(a[0]|a[1])&!a[2]&!a[3]|!a[0]&!a[1]&a[2]&!a[3];
  assign b[3]=!a[0]&!a[1]&!a[2]&!a[3];
endmodule

module shifter(input [7:0]i, input [3:0] n,input rot, ar, lr, output [7:0] o);
  logic [7:0] a,l0,l1,l2,l3,l4,l5;
  logic [3:0] c_n;
  _to_8 t0(n,c_n);
  arimetric ari(i,a);
  funnel_shifter fs0(i,i,c_n,l0);
  funnel_shifter fs1(i,i,n,l1);
  funnel_shifter fs2(i,8'b00000000,c_n,l2);
  funnel_shifter fs3(a,i,n,l3);  
  funnel_shifter fs4(i,8'b00000000,c_n,l4);
  funnel_shifter fs5(8'b00000000,i,n,l5);
  assign o =  rot ? (lr? l0 :l1) : 
    (ar ?	(lr ? l2: l3 ) :
     (lr ? l4 : l5 ) );
endmodule
