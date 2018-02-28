module stopwatch_main(clk,key_reset,key_start_pause,key_display,
							data0,data1,data2,data3,data4,data5,
							led0,led1,led2,led3);
	input	clk,key_reset,key_start_pause,key_display;
	output [3:0] data0,data1,data2,data3,data4,data5;
	output led0,led1,led2,led3;
	
	reg [3:0] data0,data1,data2,data3,data4,data5;
	reg led0,led1,led2,led3;
	
	reg display_work;
	reg counter_work;
	//parameter DELAY_TIME=10000000;
	
	reg [3:0] minute_display_high;
	reg [3:0] minute_display_low;
	reg [3:0] second_display_high;
	reg [3:0] second_display_low;
	reg [3:0] msecond_display_high;
	reg [3:0] msecond_display_low;
	
	reg [3:0] minute_counter_high;
	reg [3:0] minute_counter_low;
	reg [3:0] second_counter_high;
	reg [3:0] second_counter_low;
	reg [3:0] msecond_counter_high;
	reg [3:0] msecond_counter_low;
	
	reg [31:0] counter_50M;
	
	reg [31:0] counter_reset;
	reg [31:0] counter_start;
	reg [31:0] counter_display;
	
	reg start;
	reg display;
	reg display_flag;
	reg reset;
	
	initial
		begin
		led0=1;
		led1=0;
		led2=0;
		led3=0;
		start=1;
		display=0;
		minute_counter_low=4'd0;
		minute_counter_high=4'd0;
		second_counter_low=4'd0;
		second_counter_high=4'd0;
		msecond_counter_low=4'd0;
		msecond_counter_high=4'd0;
		minute_display_low=4'd0;
		minute_display_high=4'd0;
		second_display_low=4'd0;
		second_display_high=4'd0;
		msecond_display_low=4'd0;
		msecond_display_high=4'd0;
		end
	
	always @(posedge clk)
		begin
		if (!key_reset)
		begin
			minute_counter_low=4'd0;
			minute_counter_high=4'd0;
			second_counter_low=4'd0;
			second_counter_high=4'd0;
			msecond_counter_low=4'd0;
			msecond_counter_high=4'd0;
			reset=1;
			led3=reset;
		end
		if (!key_display)
		begin
			if (!display_flag)
			begin
			minute_display_high=minute_counter_high;
			minute_display_low=minute_counter_low;
			second_display_high=second_counter_high;
			second_display_low=second_counter_low;
			msecond_display_high=msecond_counter_high;
			msecond_display_low=msecond_counter_low;
			display_flag=1;
			end
		end
		else display_flag=0;
		
		if (clk)
		begin

			if (start==1)
			begin
				if (msecond_counter_low>=4'd9)
				begin
					msecond_counter_low=4'd0;
					if (msecond_counter_high>=4'd9)
					begin
						msecond_counter_high=4'd0;
						if (second_counter_low>=4'd9)
						begin
							second_counter_low=4'd0;
							if (second_counter_high>=4'd5)
							begin
								second_counter_high=4'd0;
								if (minute_counter_low>=4'd9)
								begin
									minute_counter_low=4'd0;
									if (minute_counter_high>=4'd5)
									begin
										minute_counter_high=4'd0;
									end
									else minute_counter_high=minute_counter_high+4'd1;
								end
								else minute_counter_low=minute_counter_low+4'd1;
							end
							else second_counter_high=second_counter_high+4'd1;
						end
						else second_counter_low=second_counter_low+4'd1;
					end
					else msecond_counter_high=msecond_counter_high+4'd1;
				end
				else msecond_counter_low=msecond_counter_low+4'd1;
			end
			if (display==0)
			begin
				data0=msecond_counter_low;
				data1=msecond_counter_high;
				data2=second_counter_low;
				data3=second_counter_high;
				data4=minute_counter_low;
				data5=minute_counter_high;
			end
			else if (display==1)
			begin
				data0=msecond_display_low;
				data1=msecond_display_high;
				data2=second_display_low;
				data3=second_display_high;
				data4=minute_display_low;
				data5=minute_display_high;
			end
		end
		
		end
	
/*	always @(negedge key_reset)
		begin
		minute_counter_low<=4'd0;
		minute_counter_high<=4'd0;
		second_counter_low<=4'd0;
		second_counter_high<=4'd0;
		msecond_counter_low<=4'd0;
		msecond_counter_high<=4'd0;
		start=0;
		display=0;
		end
	*/	
	always @(negedge key_reset or negedge key_start_pause)
		begin
			if(!key_reset)
			begin
				start=0;
			end
			else if (!key_start_pause)
			begin
				start=~start;
			end
		led1=start;
		end
	
	always @(negedge key_reset or negedge key_display)
		begin
			if(!key_reset)
			begin
				display=0;
			end
			else if (!key_display)
			begin
				display=~display;
			end;
		led2=display;
		end
	
endmodule