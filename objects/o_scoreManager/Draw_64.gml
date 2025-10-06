draw_set_font(fnt_score);
draw_set_valign(fa_top);

// top left
draw_set_halign(fa_left);
draw_set_color(c_red); 
draw_text(32, 32, string(global.p1_score));

// top right
draw_set_halign(fa_right);
draw_set_color(c_green); 
var gui_width = display_get_gui_width();
draw_text(gui_width - 32, 32, string(global.p2_score));


draw_set_color(c_white);
draw_set_halign(fa_left);
