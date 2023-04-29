module top(reset,clk,ps2clk,ps2data,hsync,vsync, Rout, Gout, Bout,pwm);
input reset,clk;
input ps2clk,ps2data;
output hsync,vsync;
output [2:0]Rout,Gout,Bout;
wire [7:0]scancode,data_out;
wire clkdiv4,display_area,clk,reset,flag,char_enable;
wire [5:0] start_address_out,address_output;
wire serial_output;
wire [3:0]no_line;


pixel_clk pix (clk,reset,clkdiv4);
kbd_protocol kbdp (reset, clkdiv4, ps2clk, ps2data, scancode,flag);
        scancode_decoder kbddec (clkdiv4,flag,scancode,start_address_out,char_enable); 
vgasync syn (clkdiv4,reset,hsync,vsync,display_area,no_line);
correct_line cl(no_line,display_area,start_address_out,address_output);
myRom chr (char_enable,address_output,data_out);
piso ps(reset,data_out,clkdiv4,display_area,serial_output);
makeRGB clr (reset,clkdiv4,display_area,serial_output,Rout,Gout,Bout);
make_pwm mpwm(clkdiv4,scancode,pwm)
        
endmodule 
