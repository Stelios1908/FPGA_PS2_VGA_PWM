module vgasync(clk25,reset,hsync,vsync,display_area,line);
input clk25,reset;

output hsync,vsync,display_area;
output[3:0] line;
wire hsync,vsync;
reg [9:0] left,right;
reg [8:0] top,down;
reg [9:0] pixel_counter;
reg [8:0] line_counter;

//orizontal pixel
parameter H_FRONT_PORCH = 16 ;
parameter H_SYNC_PULSE = 96 ;
parameter H_BACK_PORCH = 48 ;
parameter H_VISIBLE_PIXELS = 640 ;
parameter H_END=800;
//vertical pixel
parameter V_FRONT_PORCH = 12 ;
parameter V_SYNC_PULSE = 2 ;
parameter V_BACK_PORCH = 35 ;   
parameter V_VISIBLE_LINES = 400 ;
parameter V_END=449;

//Border for display area
parameter H_LEFT_BORDER=475;
parameter H_RIGHT_BORDER=483;
parameter V_TOP_BORDER=241;
parameter V_BOTTOM_BORDER=256;



always @(posedge clk25 or posedge reset) 
begin
    if (reset) 
    begin
        pixel_counter<=10'd0;
        line_counter<=9'd0;
		
        //this variable maybe i use if i want play with character on the diapla
		top   <=V_TOP_BORDER;
        left  <=H_LEFT_BORDER;
        down  <=V_BOTTOM_BORDER;
        right <=H_RIGHT_BORDER;
		  
    end

    else if (pixel_counter==H_END) //pixel counter is at the right border
         begin
             pixel_counter<=10'd0;
             //last line?0:line_cnt++
             if (line_counter==V_END) line_counter<=9'd0;
             else line_counter<=line_counter+9'd1; //alliws afksanoume ton line_counter
         end
         //pixel cnt always ++ or =0
    else pixel_counter<=pixel_counter+10'd1;   
    end
    

 //hsync signal is 0 when this is after H_FRONT_PORCH but before H_FRONT_PORCH 112 > pc > 15
assign hsync =(pixel_counter>H_FRONT_PORCH-1 && pixel_counter<H_FRONT_PORCH+H_SYNC_PULSE)? 0:1; 
//vsync signal with same thinking 14> lc > 11
assign vsync =(line_counter>V_FRONT_PORCH-1 && line_counter<V_FRONT_PORCH+V_SYNC_PULSE)? 1:0; 

//display arrea is inside at the  square with border left,right,top,down.
assign display_area=(pixel_counter>=left && pixel_counter<= right && line_counter>=top && line_counter<=down)? 1:0;

//when the line_cnt is bigger than top with mine i take the ofset.
//when the result of mine is grater than height of display square i have not problem 
//because desplay_area=0
assign line[3:0]=(line_counter>=top ) ? (line_counter - top):0;

endmodule

