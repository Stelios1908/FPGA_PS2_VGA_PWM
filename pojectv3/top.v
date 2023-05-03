module top(reset,clk,ps2clk,ps2data,hsync,vsync, Rout, Gout, Bout,pwm);
input reset,clk;
input ps2clk,ps2data;
output hsync,vsync,pwm;
output [2:0]Rout,Gout,Bout;
wire [7:0]scancode,data_out;
wire clkdiv4,display_area,clk,reset,flag,char_enable;
wire [5:0] start_address_out,address_output;
wire serial_output,Radd,Gadd,Badd;
wire [3:0]no_line;


pixel_clk pix (clk,reset,clkdiv4);
kbd_protocol       kbdp(reset,clkdiv4, ps2clk, ps2data, scancode,flag);

scancode_decoder kbddec(reset,clkdiv4,flag,scancode,start_address_out,char_enable,Radd,Gadd,Badd); 
correct_line cl(no_line,display_area,start_address_out,address_output);
myRom       chr(char_enable,address_output,data_out);
piso         pss(reset,data_out,clkdiv4,display_area,serial_output);

vgasync     syn(clkdiv4,reset,hsync,vsync,display_area,no_line);
makeRGB     clr(reset,clkdiv4,display_area,serial_output,Radd,Gadd,Badd,Rout,Gout,Bout);
make_pwm   mpwm(reset,clkdiv4,scancode,pwm);
        
endmodule
