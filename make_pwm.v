module  TwentyHz(reset,pixclk,outclk);
input reset,pixclk;
output pwm_clk;
reg  [4:0 ] cnt;

assign pwm_clk =(cnt==5'd24)
always @(posedge pixclk or posedge reset)
 begin
    if(reset) cnt<=5'd0;
     else
       begin
         if(cnt==4'd24) cnt<=5'd0;
         else cnt <=cnt+1;
       end
 end
endmodule

module make_pwm(outclk,scancode,pwm);
input outclk;
input [7:0] scancode
output pwm;
reg [8:0]cnt;
wire sinoro;
 assign  sinoro = (scancode==8'h2B)?20:
                  (scancode==8'h15)?25:
                  (scancode==8'h33)?30:
                  (scancode==8'h22)?40:0

assign pwm=(cnt=<sinoro)?1:0;

  always @(posedge outclk) 
   begin
      if(cnt==400) cnt<=0;
      else cnt<=cnt+1;
  end
endmodule