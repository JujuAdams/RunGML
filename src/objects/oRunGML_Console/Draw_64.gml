if !enabled exit;
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font);
var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();

var _draw_line_text = wrap_string(line_text, _gui_width);
var _draw_history_text = wrap_string(history_text, _gui_width);

var _line_height =  string_height(_draw_line_text);
var _history_height = string_height(_draw_history_text);

var _text_x = 0;
var _text_y = _gui_height - _line_height;
var _history_text_y = _text_y - _history_height;

draw_set_alpha(line_bg_alpha);
draw_rectangle_color(_text_x, _gui_height - _line_height, _gui_width, _gui_height, line_bg_color, line_bg_color, line_bg_color, line_bg_color, false);
draw_set_alpha(text_alpha);
draw_set_color(text_color);
//draw_text_ext(text_x, text_y, line_text, _line_h, display_get_gui_width());
draw_text(_text_x, _text_y, _draw_line_text)


draw_set_alpha(history_bg_alpha);
draw_rectangle_color(_text_x, _history_text_y, _gui_width, _history_text_y+_history_height, history_bg_color, history_bg_color, history_bg_color, history_bg_color, false);
draw_set_alpha(text_alpha);
draw_set_color(text_color);
//draw_text_ext(text_x, history_text_y, history_text, global.RunGML_Console_lineHeight, display_get_gui_width());
draw_text(_text_x, _history_text_y, _draw_history_text);