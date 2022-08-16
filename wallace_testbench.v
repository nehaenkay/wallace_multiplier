module wallace_testbench;
reg [7:0]a;
reg [7:0]b;
wire [15:0]result;

wallace_multiplier DUT (.a(a),.b(b),.result(result));
initial
begin

a = 8'd20;b = 8'd30; #10;
a = 8'd9; b = 8'd9 ;#20;
a = 8'd20; b = 8'd20; #20;
a = 8'd12; b = 8'd14; #20;
a = 8'd35; b = 8'd40;#20;
a = 8'd77; b = 8'd55; #20;
a = 8'd72; b = 8'd100; #20;
a = 8'd90; b = 8'd90; #20;
a = 8'd99; b = 8'd99; #20;
#5 $finish;


end
endmodule
