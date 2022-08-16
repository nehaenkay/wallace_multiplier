module ha(a,b,sum_h,carry_h);
input a,b;
output sum_h,carry_h;
assign sum_h = a^b;
assign carry_h = a&b;
endmodule

module fa(a,b,cin,sum_f,carry_f);
input a,b,cin;
output sum_f,carry_f;
assign sum_f = a^b^cin;
assign carry_f = (a&b) | (b&cin) | (a&cin);
endmodule


module wallace_multiplier(a,b,result);
input [7:0] a,b;
//input carry_in;
output[15:0] result;

wire [16:0]hs,hc; wire [38:0]fs,fc;
//wire p00, hs0,hc0,fs0,fc0,fs1,fc1,fs2,fc2
reg pp[7:0][7:0];
integer i,j;
 
always@(a or b)
begin
for( i = 0; i<8; i=i+1) 
for( j = 0;j<8;j=j+1)
pp[i][j] <= a[j]&b[i]; 
end

// capacity = 6 

// half adders
ha h0(pp[0][1],pp[1][0],hs[0],hc[0]);

// full adders
fa f0(pp[0][2],pp[1][1],pp[2][0],fs[0],fc[0]);
fa f1(pp[0][3],pp[1][2],pp[2][1],fs[1],fc[1]);
fa f2(pp[0][4],pp[1][3],pp[2][2],fs[2],fc[2]);
fa f3(pp[0][5],pp[1][4],pp[2][3],fs[3],fc[3]);
fa f4(pp[3][2],pp[4][1],pp[5][0],fs[4],fc[4]);
fa f5(pp[0][6],pp[1][5],pp[2][4],fs[5],fc[5]);
fa f6(pp[3][3],pp[4][2],pp[5][1],fs[6],fc[6]);
fa f7(pp[0][7],pp[1][6],pp[2][5],fs[7],fc[7]);
fa f8(pp[3][4],pp[4][3],pp[5][2],fs[8],fc[8]);
fa f9(pp[1][7],pp[2][6],pp[3][5],fs[9],fc[9]);
fa f10(pp[4][4],pp[5][3],pp[6][2],fs[10],fc[10]);
fa f11(pp[2][7],pp[3][6],pp[4][5],fs[11],fc[11]);
fa f12(pp[5][4],pp[6][3],pp[7][2],fs[12],fc[12]);
fa f13(pp[3][7],pp[4][6],pp[5][5],fs[13],fc[13]);
fa f14(pp[4][7],pp[5][6],pp[6][5],fs[14],fc[14]);
fa f15(pp[5][7],pp[6][6],pp[7][5],fs[15],fc[15]);



ha h1(fs[0],hc[0],hs[1],hc[1]);
ha h2(fc[8],pp[7][1],hs[2],hc[2]);

fa f16(fs[1],fc[0],pp[3][0],fs[16],fc[16]);
fa f17(fs[2],fc[1],pp[3][1],fs[17],fc[17]);
fa f18(fs[3],fc[2],fs[4],fs[18],fc[18]);
fa f19(fs[5],fc[3],fs[6],fs[19],fc[19]);
fa f20(fs[7],fc[5],fs[8],fs[20],fc[20]);
fa f21(fc[6],pp[6][1],pp[7][0],fs[21],fc[21]);
fa f22(fs[9],fc[7],fs[10],fs[22],fc[22]);
fa f23(fs[11],fc[9],fs[12],fs[23],fc[23]);
fa f24(fc[11],fs[13],fc[12],fs[24],fc[24]);
fa f25(fs[14],fc[13],pp[7][4],fs[25],fc[25]);
fa f26(pp[6][7],pp[7][6],fc[15],fs[26],fc[26]);


ha h3(fs[16],hc[1],hs[3],hc[3]);

fa f27(fs[17],fc[16],pp[4][0],fs[27],fc[27]);
fa f28(fs[19],fc[18],fc[4],fs[28],fc[28]);
fa f29(fs[20],fc[19],fs[21],fs[29],fc[29]);
fa f30(fs[22],fc[20],hs[2],fs[30],fc[30]);
fa f31(fs[23],fc[22],fc[10],fs[31],fc[31]);
fa f32(fs[24],fc[23],pp[6][4],fs[32],fc[32]);
fa f33(fc[14],fc[25],fs[15],fs[33],fc[33]);

ha h4(fs[27],hc[3],hs[4],hc[4]);
ha h5(fs[28],pp[6][0],hs[5],hc[5]);
ha h6(fs[29],fc[28],hs[6],hc[6]);



fa f34(fs[18],fc[27],fc[17],fs[34],fc[34]);
fa f35(fs[30],fc[29],fc[21],fs[35],fc[35]);
fa f36(fs[31],fc[30],hc[2],fs[36],fc[36]);
fa f37(fs[32],fc[31],pp[7][3],fs[37],fc[37]);
fa f38(fs[25],fc[32],fc[24],fs[38],fc[38]);

ha h7(fs[34],hc[4],hs[7],hc[7]);
ha h8(hs[5],fc[34],hs[8],hc[8]);
ha h9(hs[6],hc[5],hs[9],hc[9]);
ha h10(fs[35],hc[6],hs[10],hc[10]);
ha h11(fs[36],fc[35],hs[11],hc[11]);
ha h12(fs[37],fc[36],hs[12],hc[12]);
ha h13(fs[38],fc[37],hs[13],hc[13]);
ha h14(fs[33],fc[38],hs[14],hc[14]);
ha h15(fs[26],fc[33],hs[15],hc[15]);
ha h16(pp[7][7],fc[26],hs[16],hc[16]);


assign result[0] = pp[0][0],
	   result[1] = hs[0],
	   result[2] = hs[1],
	   result[3] = hs[3],
	   result[4] = hs[4],
	   result[5] = hs[7],
	   result[6] = hs[8],
	   result[7] = hs[9],
	   result[8] = hs[10],
	   result[9]  = hs[11],
	   result[10]  = hs[12],
	   result[11]  = hs[13],
	   result[12]  = hs[14],
	   result[13]  = hs[15],
	   result[14]  = hs[16],
	   result[15] = hc[16];
		
endmodule