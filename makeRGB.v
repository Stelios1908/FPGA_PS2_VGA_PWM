module makeRGB(reset,vga_clk,display_area,serial_output,R,G,B);
input reset,vga_clk,display_area;
input serial_output;
output reg [2:0]  R,G,B;


always @(posedge vga_clk or posedge reset) //to be replaced with vga_clk?
begin
if (reset)
    begin 
	   R <= 0;
	   G <= 0;
	   B <= 0;
    end
else
   if (display_area & serial_output)
    begin
        R=3'b111;
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


