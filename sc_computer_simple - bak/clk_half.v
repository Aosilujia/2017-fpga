module clk_half(clk_50M,clk_25M);
	input clk_50M;
	output reg clk_25M;
	
	initial clk_25M<=clk_50M;
	
	always @(posedge clk_50M)
		clk_25M<=~clk_25M;

endmodule
