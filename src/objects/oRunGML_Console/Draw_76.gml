if !enabled exit;

var blinking_cursor = cursor;
if frac(age) > 0.5 {
	blinking_cursor = " ";
}

line_text = string(prompt) + string(string_insert(blinking_cursor, current_line, cursor_pos));
history_text = "";
var _history_len = array_length(history)
for (var i=0; i<_history_len; i++) {
	history_text += string(history[i]) + "\n";
}