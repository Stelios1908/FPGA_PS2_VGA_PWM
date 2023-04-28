module scancode_decoder(flag,scancode,start_address_out,char_enable);
input [7:0] scancode;
input flag;
output reg char_enable;
output reg [5:0] start_address_out;


//edo kati lipi
always @(posedge flag ) 
begin //to be replaced with vga_clk
char_enable<=0;
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
	   default : char_enable<=0;
     endcase
  end
end
endmodule



