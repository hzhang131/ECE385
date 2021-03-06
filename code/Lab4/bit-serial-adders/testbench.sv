module testbench();

timeunit 10ns;

timeprecision 1ns;

logic Clk = 0;
logic Reset, LoadB, Run;
logic[15:0] SW;

logic[15:0] Sum;
logic[15:0] Sum_ans;
logic CO;
logic[6:0] Ahex0, Ahex1, Ahex2, Ahex3, Bhex0, Bhex1, Bhex2, Bhex3;

integer errorCnt = 0;

adder16 adder16_0(.*);

always begin : CLOCK
	#1 Clk = ~Clk;
end

initial begin:CLOCK_INITIALIZATION
	Clk = 0;
end

initial begin: TEST_VECTORS
	Reset = 0;
	LoadB = 1;
	Run = 1;
	SW = 16'h0000;
	
	#2 Reset = 1;
	SW = 16'hABCD;
	#2 LoadB = 0;
	#2 LoadB = 1;
	SW = 16'h3456;
	
	#2 Run = 0;
	#20 Run = 1;
	
	Sum_ans = 16'hE023;
	
	if(Sum_ans != Sum)
		errorCnt++;
	
	if(errorCnt == 0)
		$display("OK!");
	else
		$display("Failed!");
	end
endmodule
