module makeRGB(reset,vga_clk,display_area,serial_output,Radd,Gadd,Badd,R,G,B);
input reset,vga_clk,display_area;
input serial_output,Radd,Gadd,Badd;
output reg [2:0]  R,G,B;

reg [2:0]cnt;

always @(posedge vga_clk or posedge reset)
  begin
    if(reset) cnt<=0;
    else cnt<=cnt+1;
	end  
  


always @(posedge vga_clk or posedge reset) //to be replaced with vga_clk?
begin
if (reset)
    begin 
	   R = 0;
	   G = 0;
	   B = 0;
		
    end
else
   if (display_area & serial_output) 
    begin
	   if(Radd)
	      begin 
            R=3'b111;
            G=3'b000;
            B=3'b000;
         end
		else if(Gadd)	
	     begin 
            R=3'b000;
            G=3'b111;
            B=3'b000;
         end
		else if(Badd)
         begin 
            R=3'b000;
            G=3'b000;
            B=3'b111;
         end
		else
		   begin 
            R=3'b111;
            G=3'b111;
            B=3'b111;
         end
		end
		else if(0)
		     begin
			   R={cnt[0],cnt[2],cnt[1]};
            G=3'b111;
            B=3'b111;
			  
			  end
     else	
        begin	  
			  R=3'b000;
           G=3'b000;
		     B=3'b000;
			end
end	


endmodule


