module pixel_clk(clk,reset,clkdiv4);
input clk, reset;
output clkdiv4;
reg [1:0] cnt;
assign clkdiv4=(cnt==2'd3);
always@(posedge clk or posedge reset)
begin
    if (reset) cnt<=2'd0;
    else 
     begin
        if (cnt==2'd3) cnt <= 2'd0;   
        else           cnt <= cnt+1;
     end
end
endmodule
