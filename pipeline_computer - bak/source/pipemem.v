module pipemem( mwmem,malu,mb,clock,mem_clock,mmo,
					in_port0,in_port1,out_port0,out_port1,in_data,moutdata);
	input mwmem,clock,mem_clock;
	input [31:0] malu,mb;
	
	output [31:0] mmo;
	
	//io
	input [31:0] in_port0,in_port1;
	output [31:0] out_port0,out_port1;
	output [31:0] moutdata;
	output [31:0] in_data;
	
	wire write;
	wire write_datamem_enable;
	wire write_io_output_reg_enable;
	
	assign write=mwmem;//&(~clock);
	assign write_datamem_enable = write & ( ~ malu[7]);
	assign write_io_output_reg_enable = write & ( malu[7]); 
	


	lpm_ram_dq_dram dram(malu[6:2],mem_clock,mb,write_datamem_enable,moutdata);

	io_output_reg io_output_regx2 (malu,mb,write_io_output_reg_enable,mem_clock,1,out_port0,out_port1);
		
	io_input_reg io_input_regx2(malu,mem_clock,in_data,in_port0,in_port1);
	
	mux2x32 mem_io_dataout_mux(moutdata,in_data,malu[7],mmo);
endmodule
