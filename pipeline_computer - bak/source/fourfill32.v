module fourfill32(button4,io32);
	input [3:0] button4;
	output [31:0] io32;
	reg [31:0] io32;
	always  @ (*)
	begin
		io32=0;
		io32[3]=button4[3];
		io32[2]=button4[2];
		io32[1]=button4[1];
		io32[0]=button4[0];
	end	
endmodule