
module make_pwm(reset,clkdiv4,scancode,pwm);
input reset,clkdiv4;
input [7:0] scancode;
output pwm;
reg [9:0]cnt=0;
wire [6:0]sinoro;
wire reset,clkdiv4,first,second;

cnt25 i0 (reset, clkdiv4, 1'b1, first);
cnt25 i1 (reset, clkdiv4, first, second);
assign en_nxt = first & second;

 assign  sinoro = (scancode==8'h2B)?41://f
                  (scancode==8'h15)?51://q
                  (scancode==8'h33)?61://h
                  (scancode==8'h22)?81:sinoro;//x

assign pwm=(cnt<sinoro)?1:0;

  always @(posedge clkdiv4 or posedge reset) 
   begin
     if(reset) begin cnt <= 9'd0;  end
     else if(en_nxt)
        begin
         if(cnt==10'd800) cnt<= 10'd0;
         else cnt<=cnt+10'd1;
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