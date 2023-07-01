module correct_line(no_line,display_area,starting_address,address_output);
input [5:0]starting_address;
input [3:0]no_line;
input display_area;
output [5:0]address_output;

//an den eimasrte sthn energo perioxi bgazv 0 gia mayro
assign address_output=(display_area) ? starting_address+no_line:0;
endmodule
