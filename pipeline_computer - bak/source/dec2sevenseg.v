module dec2sevenseg (data_in,data_out1,data_out2);
	input [4:0] data_in;
	output [3:0] data_out1;
	output [3:0] data_out2;
	reg [3:0] data_out1,data_out2;
	always @(*)
		begin
		data_out1=data_in /10;
		data_out2=data_in %10;
		end
		
endmodule