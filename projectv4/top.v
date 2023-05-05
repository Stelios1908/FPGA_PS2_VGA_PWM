module top(reset,clk,ps2clk,ps2data,hsync,vsync, Rout, Gout, Bout,pwm);
input reset,clk;
input ps2clk,ps2data;
output hsync,vsync,pwm;
output [2:0]Rout,Gout,Bout;
wire [7:0]scancode,data_out;
wire clkdiv4,display_area,clk,reset,flag,char_enable;
wire [5:0] start_address_out,address_output;
wire serial_output,Radd,Gadd,Badd,tenH_clk;
wire [3:0]no_line;


pixel_clk pix (clk,reset,clkdiv4);
kbd_protocol       kbdp(reset,clkdiv4, ps2clk, ps2data, scancode,flag);
TenHertz th (reset,clk,tenH_clk);

scancode_decoder kbddec(reset,clkdiv4,flag,scancode,start_address_out,char_enable,Radd,Gadd,Badd); 
correct_line cl(no_line,display_area,start_address_out,address_output);
myRom       chr(char_enable,address_output,data_out);
piso         pss(reset,data_out,clkdiv4,display_area,serial_output);

vgasync     syn(clkdiv4,reset,hsync,vsync,display_area,no_line);
makeRGB     clr(reset,clkdiv4,tenH_clk,display_area,serial_output,Radd,Gadd,Badd,Rout,Gout,Bout);
make_pwm   mpwm(reset,clkdiv4,scancode,pwm);
        
endmodule

/*

module test_top();

wire h,v,pem;
wire [2:0] R,G,B;
reg reset,clk,ps2clk,ps2data;

top CUT(reset,clk,ps2clk,ps2data,h,v, R, G, B,pwm);


initial
   begin 
       #10 clk = 0;
       #10 ps2clk =0;
       #10 reset = 0;
       #10 reset = 1;
       #10 reset = 0;
       #10 ps2data =0;
  end

always #1 clk=~clk;
always begin #100 ps2clk=~ps2clk; end
initial begin 
     
               #98  ps2data=0;//start
               #200 ps2data=0;
               #200 ps2data=0;
               #200 ps2data=0;
               #200 ps2data=0;
               #200 ps2data=1;
               #200 ps2data=1;
               #200 ps2data=1;
               #200 ps2data=1; 
               #200 ps2data=1;//parity
               #200 ps2data=1;//end

               #200 ps2data=0;//start
               #200 ps2data=1;
               #200 ps2data=0;
               #200 ps2data=1;
               #200 ps2data=0;
               #200 ps2data=1;
               #200 ps2data=0; 
               #200 ps2data=0; 
               #200 ps2data=0;  
               #200 ps2data=0; 
               #200 ps2data=1; 
         end
     initial begin
     #20000020;
     $finish;
  end
   initial 
   begin
    $dumpfile("dump.vcd");   
    $dumpvars(0);
    end
endmodule

*/