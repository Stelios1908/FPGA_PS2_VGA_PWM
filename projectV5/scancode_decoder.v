module scancode_decoder(reset,vga_clk,flag,scancode,start_address_out,char_enable,RGB);
input [7:0] scancode;
input reset,vga_clk,flag;
output reg char_enable;
output reg [2:0]RGB;
output reg [5:0] start_address_out;


//edo kati lipi
always @(posedge vga_clk or posedge reset ) 
begin //to be replaced with vga_clk
if(reset)
   begin
    char_enable<=0;
     RGB<=3'b000;	
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
					
			8'h2d://R
			   RGB=3'b100;
            8'h34://G
			   RGB=3'b010;
	        8'h32://B
			   RGB=3'b001;
            8'h44://O
		       RGB=3'b000;
			8'h23://D
			   RGB=3'b111;
     default : char_enable<=0;
     endcase
  end
  end
end
endmodule



