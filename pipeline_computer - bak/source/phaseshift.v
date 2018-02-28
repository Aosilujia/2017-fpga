module phaseshift(clock,mem_clock);
	input clock;
	output reg mem_clock;
	always @(*)
		mem_clock=~clock;
endmodule
