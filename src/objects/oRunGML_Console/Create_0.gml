var _me = id;
with(oRunGML_Console) {
	if id != _me instance_destroy();
}
global.RunGML_Console = _me;

RunGMLI = new RunGML_Interpreter("Console");
RunGMLI.parent = id;
RunGMLI.throw_errors = true;

last_created = noone;

toggle_key = global.RunGML_Console_toggleKey;
backspace_key = vk_backspace;
float_precision = global.RunGML_Console_floatPrecision;

age = 0;

prompt = "> ";
outprompt = "-> "
current_line = "";
cursor = "|"
cursor_pos = 1; // String indexes start at 1
history = [];
max_history = 20;
command_history = [];
command_history_pos = -1;
command_history_max = 100;
pause_game = true;

scaledown = 1.0;
left_padding = 8/scaledown;
right_padding = 8/scaledown;
top_padding = 4/scaledown;
bottom_padding = 4/scaledown;

text_color = c_lime;
text_alpha = 1.0;
line_bg_color = c_black;
line_bg_alpha = 0.75;
history_bg_color = c_dkgrey;
history_bg_alpha = 0.75;
font = global.RunGML_Console_font;

alphabet = [
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
	"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
	"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", 
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "=",
	"!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+", 
	",", ".", "/", "<", ">", "?", " ", ":", ";", "'", "[", "]", "'", "\"", "{", "}"
];

toggle = function(_set=!enabled) {
	enabled = _set;
	if enabled {
		age = 0;
		if pause_game global.paused = true;
	} else {
		keyboard_lastkey = -1;
		keyboard_lastchar = "";
		clear_line();
		command_history_pos = 0;
		if pause_game global.paused = false;
	}
}

clear_line = function() {
	current_line = "";
	cursor_pos = 1;
}

clear_history = function() {
	history = [];	
}

log_line = function(_l) {
	array_push(history, _l);
	if array_length(history) > max_history {
		array_delete(history, 0, 1);
	}
}

log_string = function(_s) {
	var lines = string_split(_s, ord("\n"));
	for (var i=0; i<array_length(lines); i++) {
		log_line(lines[i]);
	}
}

trim_numeric_string = function(_s) {
	_s = string_format(_s, 1, float_precision);
	_s = string_trim_end(_s, ["0"])
	if string_char_at(_s, string_length(_s)) == "." {
		_s += "0";
	}
	return _s;
}

wrap_string = function(_s, _w=undefined) {
	if is_undefined(_w) _w = display_get_gui_width();
	var _char_w = string_width("_");
	var _chars_per_line = floor(_w/_char_w)
	var _start_len = string_length(_s);
	var _i = _chars_per_line;
	var _added = 0;
	while _i <= _start_len + _added {
		_s = string_insert("\n", _s, _i);
		_added += 1
		_i += _chars_per_line + _added;
	}
	return _s;
}

//wrap_string = function(_s, _w=250, _sep=[" ", ",", "-", "_", ")", "]", "}", "\n"]) {
//	var _wrapped, _last, _len, _portion, _remaining, _s_line, _char, _done;
//	var _lines = string_split(_s, "\n");
	
//	for (var _line=0; _line<array_length(_lines); _line++) {
//		_wrapped = "";
//		_s_line = _lines[_line];
//		_done = false
//		while not _done {
//			_last = noone;
//			for (var i=1; i<=_w; i++) {
//				if i > string_length(_s_line) _last = i-1;
//				_char = string_char_at(_s_line, i);
//				if array_contains(_sep, _char) _last = i;
//			}
//			if _last == noone _last = _w;
//			_portion = string_copy(_s_line, 1, _last)
//			_remaining = string_length(_s_line) - string_length(_portion)
//			if string_length(_wrapped) > 0 _wrapped += "\n";
//			_wrapped += _portion;
//			if _remaining == 0 {
//				_done = true;
//				continue
//			}
//			_s = string_copy(_s, _last+1, _remaining);	
//		}
//		_lines[_line] = _wrapped;
//	}
//	return string_join_ext("\n", _lines);
//}

exec_line = function(_l) {
	var _output = RunGMLI.run(json_parse(string("[{0}]", _l)))
	if _output == undefined return;
	if typeof(_output) == "array" {
		if array_length(_output) < 1 return;
	}
	if typeof(_output) == "number" {
		_output = trim_numeric_string(_output);
	}
	
	log_line(outprompt + string(_output));
}

backspace = function() {
	if cursor_pos > 1 {
		current_line = string_delete(current_line, cursor_pos-1, 1);
		cursor_pos -= 1;
	}
}



toggle();