module delay(clk,key_unstable,key_stable);
	input clk;
	input key_unstable;
	output key_stable;
	reg key_stable,key_tmp;
	reg [23:0] count;
	always @(posedge clk)
		begin
			if (!key_unstable)
			begin
				count=count+24'd1;
				if (count>=24'd100000)
				begin
					count=24'd100000;
				end
			end
			else count=24'd0;
			if (count>=24'd100000)
			begin
				key_stable=0;
			end
			else	key_stable=1;
		end
endmodule