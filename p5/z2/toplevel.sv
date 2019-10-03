module Gray_code_decoder_8_bit(input [7:0]a, input x,output [7:0]o,output x_o);
  assign o[7]=a[7]^x;
  genvar i;
  for (i=6;i>=0;i=i-1)
    assign o[i]=a[i]^o[i+1];
  assign x_o=o[0];
endmodule

module Gray_code_decoder_32_bit(input [31:0]i, output [31:0] o);
  Gray_code_decoder_8_bit g0(i[24+:8],1'b0,o[24+:8],x0);
  Gray_code_decoder_8_bit g1(i[16+:8],x0,o[16+:8],x1);
  Gray_code_decoder_8_bit g2(i[8+:8],x1,o[8+:8],x2);
  Gray_code_decoder_8_bit g3(i[0+:8],x2,o[0+:8],c);
endmodule
