
/*module cnt25 (reset, clk, enable, clkdiv25);
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

*/
module cnt64 (reset, clk, enable, clkdiv64);
input reset, clk, enable;
output clkdiv64;
reg [5:0] cnt;

assign clkdiv64 = (cnt==8'd63);
always @(posedge reset or posedge clk)
  if (reset) cnt <= 0;
   else if (enable)
       if(clkdiv64) cnt <= 0;
         else cnt <= cnt + 1;
endmodule

module cnt10 (reset, clk, enable, clkdiv10);
input reset, clk, enable;
output clkdiv10;
reg [3:0] cnt;

assign clkdiv10 = (cnt==8'd9);
always @(posedge reset or posedge clk)
  if (reset) cnt <= 0;
   else if (enable) 
        if(clkdiv10)cnt <=0;
           else cnt <= cnt + 1;
endmodule

module TenHertz(reset,clk,tenH_clk);
input clk, reset;
output tenH_clk;
wire clk10Hz;
wire first, second, third, fourth;

cnt25 i0 (reset, clk, 1'b1, first);
cnt25 i1 (reset, clk, first, second);
cnt25 i2 (reset, clk, first & second, third);
cnt10 i3 (reset,clk,first & second & third,fourth);
cnt64 i4 (reset, clk, first & second & third & fourth , clk10Hz);

assign tenH_clk = first & second & third & fourth & clk10Hz;
endmodule


/*
module test();

reg reset,clk;
wire outclk;
TenHertz CUT(reset,clk,outclk);

initial begin 
        #10 reset =0;
        #10 clk=0;
        #10 reset=1;
        #10 reset=0;
        end
         always #1 clk=~clk;
   initial begin
   #2000002;
    $finish;

   end
   initial 
   begin
    $dumpfile("dump.vcd");   
    $dumpvars(0);
    end


endmodule
*/