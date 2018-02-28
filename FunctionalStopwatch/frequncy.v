module frequency (clk_50M,clk_100);
	input clk_50M;
	output clk_100;
	reg [31:0] count;
	reg clk_100;
	
	always @(posedge clk_50M)
	begin
		if(count==32'd249999)
		begin
			clk_100=~clk_100;
			count=32'd0;
		end
		else
		begin
			count=count+32'd1;
		end
	end
endmodule