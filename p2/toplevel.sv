module mod(output o, input [3:0] i);
  logic a=i[0],b=i[1],c=i[2],d=i[3];
  assign o =!(!a&&!b&&!(c&&d) || !c&&!d&&!(a&&b) || a&&b&&c&&d);
endmodule
