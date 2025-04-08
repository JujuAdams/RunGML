if !enabled exit;
if !keyboard_check(vk_anykey) exit;

if keyboard_check(vk_backspace) {
	if keyboard_check_pressed(vk_backspace) {
		backspace();
	} else {
		backspace_hold_cooldown -= dt;
		if backspace_hold_cooldown <= 0 {
			backspace();
			backspace_hold_cooldown = backspace_hold_rate;	
		}
	}
	exit;
} else {
	backspace_hold_cooldown = backspace_hold_delay;
}

if keyboard_check(meta_key) {
	if keyboard_check_pressed(ord("L")) {
		clear_history();	
	}
	if keyboard_check_pressed(ord("C")) {
		clear_line();
	}
	if keyboard_check_pressed(ord("A")) {
		cursor_pos = 1;
	}
	if keyboard_check_pressed(ord("E")) {
		cursor_pos = string_length(current_line) + 1;
	}
	exit;	
}

if keyboard_check_pressed(vk_enter) {
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
}


else if keyboard_check_pressed(vk_delete) {
	current_line = string_delete(current_line, cursor_pos, 1);
	cursor_pos = max(1, min(string_length(current_line) + 1, cursor_pos));
}
		
else if keyboard_check_pressed(vk_left) {
	cursor_pos = max(1, cursor_pos - 1);
}
		
else if keyboard_check_pressed(vk_right) {
	cursor_pos = min(string_length(current_line) + 1, cursor_pos + 1);
}
		
else if keyboard_check_pressed(vk_down) and (array_length(command_history) > 0) {
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
}
		
else if keyboard_check_pressed(vk_up) and array_length(command_history) > 0 {
	command_history_pos--;
	if command_history_pos < 0 {
		command_history_pos = array_length(command_history) - 1;
	}
	current_line = command_history[command_history_pos];
	cursor_pos = string_length(current_line) + 1;
}
		
else {
	if array_contains(alphabet, keyboard_lastchar) {		
		current_line = string_insert(keyboard_lastchar, current_line, cursor_pos);
		cursor_pos += 1;
	}
}