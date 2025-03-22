if !enabled exit;

switch(keyboard_lastkey) {
	case -1:
		break;
		
	case vk_enter:
		log_line(prompt + string(current_line));
		var n_command_history = array_length(command_history)
		if n_command_history > 0 {
			if current_line != command_history[n_command_history-1] {
				array_push(command_history, current_line);
				if array_length(command_history) > command_history_max {
					array_delete(command_history, 0, 1);
				}
			}
		} else {
			array_push(command_history, current_line);
		}
		try {
			exec_line(current_line);
		} catch(_e) {
			log_string(_e);	
		}
		clear_line();
		command_history_pos = -1;
		break;
		
	case backspace_key:
		backspace();
		break;
		
	case vk_delete:
		clear_line();
		break;
		
	case vk_left:
		cursor_pos = max(1, cursor_pos - 1);
		break;
		
	case vk_right:
		cursor_pos = min(string_length(current_line) + 1, cursor_pos + 1);
		break;
		
	case vk_down:
		if array_length(command_history) == 0 break;
		command_history_pos++;
		if command_history_pos >= array_length(command_history) {
			command_history_pos = -1;
			current_line = "";
			cursor_pos = 1;
		}
		try {
			current_line = command_history[command_history_pos];
		} catch(_e) {
			current_line = "";	
		}
		cursor_pos = string_length(current_line) + 1;
		break;
		
	case vk_up:
		if array_length(command_history) == 0 break;
		command_history_pos--;
		if command_history_pos < 0 {
			command_history_pos = array_length(command_history) - 1;
		}
		current_line = command_history[command_history_pos];
		cursor_pos = string_length(current_line) + 1;
		break;
		
	default:
		if !array_contains(alphabet, string_lower(keyboard_lastchar)) {
			break;
		}
		
		if keyboard_check(vk_shift) {
			keyboard_lastchar = string_upper(keyboard_lastchar);
		}
		
		current_line = string_insert(keyboard_lastchar, current_line, cursor_pos);
		cursor_pos += 1;
		break;
}