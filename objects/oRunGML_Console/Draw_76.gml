if !enabled exit;

text_x = 0;
text_y = display_get_gui_height();;
var blinking_cursor = cursor;
if frac(age) > 0.5 {
	blinking_cursor = " ";
}

line_text = string(prompt) + string(string_insert(blinking_cursor, current_line, cursor_pos));
//line_text = RunGMLI.run(["string_wrap", line_text]);
history_text = "";
for (var i=0; i<array_length(history); i++) {
	history_text += string(history[i]) + "\n";
}
//history_text = RunGMLI.run(["string_wrap", history_text]);
history_text_y = text_y - string_height(line_text)