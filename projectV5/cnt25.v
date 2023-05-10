module cnt25 (reset, clk, enable, clkdiv25);
input reset, clk, enable;
output clkdiv25;
reg [5:0] cnt;

assign clkdiv25 =(cnt==5'd24);
always @(posedge reset or posedge clk)
  if (reset) cnt <= 0;
   else if (enable) 
          if (clkdiv25) cnt <= 0;
            else cnt <= cnt + 1;
endmodule