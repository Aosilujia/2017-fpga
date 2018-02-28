module alu (a,b,aluc,s,z);
   input [31:0] a,b;
   input [3:0] aluc;
   output [31:0] s;
   output        z;
   reg [31:0] s;
   reg        z;
	integer i;
   always @ (a or b or aluc) 
      begin                                   // event
         casex (aluc)
             4'bx000: s = a + b;              //x000 ADD
             4'bx100: s = a - b;              //x100 SUB
             4'b0001: s = a & b;              //0001 AND
             4'bx101: s = a | b;              //x101 OR
             4'bx010: s = a ^ b;              //x010 XOR
             4'bx110: s = b << 5'd16;         //x110 LUI: imm << 16bit  	 
				 4'b1001: 
				 begin
					s=0;
					for (i=0;i<32;i=i+1)
						s=s+((a[i])^(b[i]));
					
					//s=s+a[0]^b[0]+a[1]^b[1]+a[2]^b[2]+a[3]^b[3]+a[4]^b[4]+a[5]^b[5]+a[6]^b[6]+a[7]^b[7];
					
				 end//1001 hamd:hamming distance
             4'b0011: s = b << a;             //0011 SLL: rd <- (rt << sa)
             4'b0111: s = b >> a;             //0111 SRL: rd <- (rt >> sa) (logical)
             4'b1111: s = $signed(b) >>> a;   //1111 SRA: rd <- (rt >> sa) (arithmetic)
             default: s = 0;
         endcase
         if (s == 0 )  z = 1;
            else z = 0;         
      end      
endmodule 