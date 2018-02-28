module pipeexe ( ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,ejal,ern,ealu );
	input ealuimm,eshift,ejal;
	input [31:0] ea,eb,epc4,eimm;
	input [3:0] ealuc;
	input [4:0] ern0;
	
	output [31:0] ealu;
	output [4:0] ern;
	
	wire [31:0] epc8,sa,alua,alub,ealu0;
	wire zero;
	
	assign sa={27'b0,eimm[10:6]};
	plus ret_addr(epc4,32'h4,epc8);
	mux2x32 alu_choose_a(ea,sa,eshift,alua);
	mux2x32 alu_choose_b(eb,eimm,ealuimm,alub);
	alu alu_exe(alua,alub,ealuc,ealu0,zero);
	mux2x32 choose_result(ealu0,epc8,ejal,ealu);
	assign ern= ejal?5'd0:ern0; 

endmodule
