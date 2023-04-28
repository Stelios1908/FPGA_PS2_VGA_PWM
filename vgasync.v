module vgasync(clk25,reset,hsync,vsync,display_area,line);
input clk25,reset;
input [2:0] up;
output hsync,vsync,display_area;
output[3:0] line;
wire hsync,vsync;
reg [9:0] left,right;
reg [8:0] top,down;
reg [9:0] pixel_counter;
reg [8:0] line_counter;
parameter H_FRONT_PORCH = 16 ;
parameter H_SYNC_PULSE = 96 ;
parameter H_BACK_PORCH = 48 ;
parameter H_VISIBLE_PIXELS = 640 ;
parameter H_END=800;

parameter V_FRONT_PORCH = 12 ;
parameter V_SYNC_PULSE = 2 ;
parameter V_BACK_PORCH = 35 ;   
parameter V_VISIBLE_LINES = 400 ;
parameter V_END=449;

parameter H_LEFT_BORDER=475;
parameter H_RIGHT_BORDER=482;
parameter V_TOP_BORDER=216;
parameter V_BOTTOM_BORDER=231;

always @(posedge clk25 or posedge reset) 
begin
    if (reset) // an exoume energopoihmeno reset, midenise ton counter
    begin
        pixel_counter<=10'd0;
        line_counter<=9'd0;
    end

    else if (pixel_counter==H_END) //an den exoume energopoihmeno reset kai an eimaste sto deksi akro tis othonis
         begin
             pixel_counter<=10'd0;
             if (line_counter==V_END) line_counter<=9'd0; //an eimaste sthn teleftaia grammi, midenizoume ton line_counter
             else line_counter<=line_counter+9'd1; //alliws afksanoume ton line_counter
         end
    else pixel_counter<=pixel_counter+10'd1; //an den eimaste sto deksi akro tis othonis   
    end
    

 
assign hsync =(pixel_counter>H_FRONT_PORCH-1 && pixel_counter<H_FRONT_PORCH+H_SYNC_PULSE)? 0:1;//  112 > pc > 15
assign vsync =(line_counter>V_FRONT_PORCH-1 && line_counter<V_FRONT_PORCH+V_SYNC_PULSE)? 1:0; // 14> lc > 11


assign display_area=(pixel_counter>=left && pixel_counter<= right && line_counter>=top && line_counter<=down)? 1:0;
assign line[3:0]=(line_counter>=top ) ? (line_counter - top):0;

endmodule

