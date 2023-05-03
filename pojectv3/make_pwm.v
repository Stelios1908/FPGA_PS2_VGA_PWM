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


module make_pwm(reset,clkdiv4,scancode,pwm);
input reset,clkdiv4;
input [7:0] scancode;
output pwm;
reg [9:0]cnt=0;
wire [6:0]sinoro;
wire reset,pixclk,clkdiv4,outclk,first,second;

cnt25 i0 (reset, clkdiv4, 1'b1, first);
cnt25 i1 (reset, clkdiv4, first, second);
assign en_nxt = first & second;

 assign  sinoro = (scancode==8'h2B)?40:
                  (scancode==8'h15)?50:
                  (scancode==8'h33)?60:
                  (scancode==8'h22)?80:0;

assign pwm=(cnt<sinoro)?1:0;

  always @(posedge en_nxt or posedge reset) 
   begin
     if(reset) cnt <= 9'd0;
     else 
        begin
         if(cnt==800) cnt<= 9'd0;
         else cnt<=cnt+1;
        end
     end



endmodule


/*
module testmake_pwm();
  reg reset, clk;
  wire en_nxt;
  reg [7:0] scan;
  
  make_pwm CUT (reset, clk,scan,out);
  initial begin scan=0; reset=0;  clk = 0; # 10 reset = 1; # 9 reset = 0; end
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