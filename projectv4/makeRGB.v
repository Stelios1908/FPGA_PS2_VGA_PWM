module makeRGB(reset,vga_clk,tenH_clk,display_area,serial_output,Radd,Gadd,Badd,R,G,B);
input reset,vga_clk,tenH_clk,display_area;
input serial_output,Radd,Gadd,Badd;
output reg [2:0]  R,G,B;
reg b1,b2,b3;

always @(posedge tenH_clk or posedge reset) begin
 if(reset)
    begin 
     b1 <=0;
	  b2 <=0;
	  b3 <=0;	 
	 end	 
 else
  begin
     b1 <=~b1;
	  b2 <=~b2;
	  b3 <=~b3;
	  
	end  
 end 


always @(posedge vga_clk or posedge reset) //to be replaced with vga_clk?
begin
if (reset)
    begin 
	   R <= 0;
	   G <= 0;
	   B <= 0;
		
    end
else if (display_area & serial_output) 
    begin
	   if(Radd & Badd & Gadd)
	      begin 
            R<={b1,b2,b3};
            G<={b1,b2,b3};
            B<={b1,b2,b3};			
          end
		else if(Gadd)	
	     begin 
            R<=3'b000;
            G<=3'b111;
            B<=3'b000;
         end
		else if(Badd)
         begin 
            R<=3'b000;
            G<=3'b000;
            B<=3'b111;
         end
		else if(Radd)
		     begin
			   R<=3'b111;
            G<=3'b000;
            B<=3'b000;
			  
			  end			
		else
		   begin 
            R<=3'b111;
            G<=3'b111;
            B<=3'b111;
         end
	end
else	
        begin	  
           			  
			  R<=3'b000;
           G<=3'b000;
		     B<=3'b000;
			end
end	


endmodule


