module scancode_decoder(reset,vga_clk,flag,scancode,start_address_out,char_enable,R,G,B);
input [7:0] scancode;
input reset,vga_clk,flag;
output reg char_enable,R,G,B;
output reg [5:0] start_address_out;



always @(posedge vga_clk or posedge reset ) 
begin 
if(reset)
   begin
    char_enable<=0;
     R<=0;
	  G<=0;
	  B<=0;	
   end
else	 begin
   if(flag)
     begin
      case(scancode)
        8'h2B: begin //F 
					start_address_out<=6'b000000; 
					char_enable<=1; 
					end
        8'h15: begin //Q
					start_address_out<=6'b010000; 
					char_enable<=1;
					end					
        8'h33: begin //H
					start_address_out<=6'b100000; 
					char_enable<=1;
					end
        8'h22: begin //X
					start_address_out<=6'b110000 ; 
					char_enable<=1;
					end
					
			8'h2d:begin
			        R<=1;
					  G<=0;
					  B<=0;
               end	
         8'h34:begin
			        R<=0;
			        G<=1;
					  B<=0;
               end	
	      8'h32:begin
			        R<=0;
					  G<=0;
			        B<=1;
               end	
			8'h44:begin
			        R<=0;
					  G<=0;
					  B<=0;
               end	
			8'h23:begin
			        R<=1;
					  G<=1;
					  B<=1;
               end			
					
					
					
			default : char_enable<=0;
     endcase
  end
  end
end
endmodule



