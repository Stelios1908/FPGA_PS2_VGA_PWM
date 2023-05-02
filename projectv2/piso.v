module piso(reset,parallel_input,vga_clk,display_area,serial_output);
input [7:0] parallel_input;
input vga_clk,display_area,reset;
output reg serial_output;
reg [2:0]cnt;
always @(posedge vga_clk or posedge reset)
begin
 if (reset)
	begin
		cnt<=3'd0;
		serial_output<=0;
	end
	else if (display_area==0) 
    begin
    cnt<=0;
    serial_output<=0;
    end
	else //arxizei h seiriakh na ksernaei bit
		begin 
          serial_output <= parallel_input[7-cnt];

        if (cnt==3'd7)
		    cnt<=0;
        else
		 cnt<=cnt+1;
		end
end
endmodule
