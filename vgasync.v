module vgasync(clk25,reset,hsync,vsync,display_area,line);
input clk25,reset;
output hsync,vsync,display_area;
output[3:0] line;

wire hsync,vsync;
reg [9:0] pix_cnt;
reg [8:0] line_cnt;

//orizoyme tis parametroys 
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

//(16+96+48+640/2)-4
parameter H_LEFT_BORDER=475;
parameter H_RIGHT_BORDER=483;
//(12+2+35+400/2) -8
parameter V_TOP_BORDER=241;
parameter V_BOTTOM_BORDER=256;



always @(posedge clk25 or posedge reset) 
begin
    if (reset) // se periptosi reset midenise ton counter
    begin
        pix_cnt<=10'd0;
        line_cnt<=9'd0;	  
    end

  // o pix_cnt exei ftasei terma dexia
  //tote ypaexoyn dio periptoseis
    else if (pix_cnt==H_END)  
         begin
          pix_cnt<=10'd0;
          //1)an eimaste sthn teleftaia grammi tote midenizoume kai ton line_cnt
             if (line_cnt==V_END)
              line_cnt<=9'd0; 
             else
             line_cnt<=line_cnt+9'd1; //2)alliws afksanoume ton line_cnt kata ena
         end
    else pix_cnt<=pix_cnt+10'd1; //an den itan terma dexia  o line_cnt tote apla ayxanoyme kata anea   
    end
    

 // hsync mesa sta oria  112 > pc > 15
assign hsync =(pix_cnt>H_FRONT_PORCH-1 && pix_cnt<H_FRONT_PORCH+H_SYNC_PULSE)? 0:1;

//vsync mesa sta oria 2 grammon  14> lc > 11
assign vsync =(line_cnt>V_FRONT_PORCH-1 && line_cnt<V_FRONT_PORCH+V_SYNC_PULSE)? 1:0; 

//to display area einai to moito tetragono poy emfanizete o xaraktiras
assign display_area=(pix_cnt>=H_LEFT_BORDER && pix_cnt<= H_RIGHT_BORDER && line_cnt>=V_TOP_BORDER && line_cnt<=V_BOTTOM_BORDER)? 1:0;

//poses grames apexoyme apo to pano sinoro toy display area
assign line[3:0]=(line_cnt>=V_TOP_BORDER ) ? (line_cnt - V_TOP_BORDER):0;

endmodule

