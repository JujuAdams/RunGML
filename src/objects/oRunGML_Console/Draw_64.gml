if !enabled exit;
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();


draw_set_alpha(line_bg_alpha);
draw_rectangle_color(0, _gui_height - string_height(line_text), _gui_width, _gui_height, line_bg_color, line_bg_color, line_bg_color, line_bg_color, false);
draw_set_alpha(text_alpha);
draw_set_color(text_color)
//draw_text(text_x, text_y, line_text);
draw_text_ext(text_x, text_y, line_text, global.RunGML_Console_lineHeight, display_get_gui_width());

draw_set_alpha(history_bg_alpha);
draw_rectangle_color(0, history_text_y-string_height(history_text), display_get_gui_width(), history_text_y, history_bg_color, history_bg_color, history_bg_color, history_bg_color, false);
draw_set_alpha(text_alpha);
draw_set_color(text_color);
//draw_text(text_x, text_y, history_text);
draw_text_ext(text_x, history_text_y, history_text, global.RunGML_Console_lineHeight, display_get_gui_width());