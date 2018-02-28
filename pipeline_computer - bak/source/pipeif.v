module pipeif( pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock );
	input [1:0] pcsource;
	input [31:0] pc,bpc,da,jpc;
	input mem_clock;
	output [31:0] npc,pc4,ins;
	
	mux4x32 choose_pc(pc4,bpc,da,jpc,pcsource,npc);
	
	plus pc_plus4(pc,4,pc4);
	
	lpm_rom_irom irom(pc[7:2],mem_clock,ins);
	//fetch instruction
endmodule
