if !enabled exit;

var _old_halign = draw_get_halign();
var _old_valign = draw_get_valign();
var _old_color = draw_get_color();
var _old_alpha = draw_get_alpha();
var _old_font = draw_get_font();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font);

var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();

var _draw_line_text = wrap_string(line_text, _gui_width);
var _draw_history_lines = string_split(history_text, "\n");

var _draw_history_text = ""
for (var i=0; i<array_length(_draw_history_lines); i++) {
	if i > 0 _draw_history_text += "\n";
	_draw_history_text += wrap_string(_draw_history_lines[i], _gui_width);
}

var _line_height =  string_height(_draw_line_text)*text_scale;
var _history_height = string_height(_draw_history_text)*text_scale;

var _text_x = 0;
var _text_y = _gui_height - _line_height;
var _history_text_y = _text_y - _history_height;

draw_set_alpha(line_bg_alpha);
draw_rectangle_color(_text_x, _gui_height - _line_height, _gui_width, _gui_height, line_bg_color, line_bg_color, line_bg_color, line_bg_color, false);
draw_set_alpha(text_alpha);
draw_set_color(text_color);
draw_text_transformed(_text_x, _text_y, _draw_line_text, text_scale, text_scale, 0)

draw_set_alpha(history_bg_alpha);
draw_rectangle_color(_text_x, _history_text_y, _gui_width, _history_text_y+_history_height, history_bg_color, history_bg_color, history_bg_color, history_bg_color, false);
draw_set_alpha(text_alpha);
draw_set_color(text_color);
draw_text_transformed(_text_x, _history_text_y, _draw_history_text, text_scale, text_scale, 0);

draw_set_halign(_old_halign);
draw_set_valign(_old_valign);
draw_set_color(_old_color);
draw_set_alpha(_old_alpha);
draw_set_font(_old_font);

