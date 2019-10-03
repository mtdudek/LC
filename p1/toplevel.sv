module multiplexer( input a,b,c,d,x,y, output o);

  logic a1,b1,c1,d1,o1,o2,o3,o4,i1,i2;
  logic notx, noty;
  not(notx,x);
  not(noty,y);
  
  and g1(a1,notx,noty);
  and g2(o1,a1,a);
  
  and g3(b1,notx,y);
  and g4(o2,b1,b);
  
  and g5(c1,x,noty);
  and g6(o3,c1,c);
  
  and g7(d1,x,y);
  and g8(o4,d1,d);
  
  or  g9(i1,o1,o2);
  or g10(i2,o3,o4);
  or g11(o,i1,i2);
  
endmodule