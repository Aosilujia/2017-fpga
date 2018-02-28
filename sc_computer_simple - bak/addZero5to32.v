module addZero5to32(inbs, outbs);
	input [4:0] inbs;
	output reg[31:0] outbs;
	
	always @(inbs)
	begin
		outbs = 0;
		outbs[3:0] = inbs;
	end
endmodule