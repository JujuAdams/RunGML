global.RunGML_I_debug = false;

function RunGML_OpDoc(_name="RunGML Operator", _desc="Description", _args="[]", _out="[]") constructor {
	name = _name;
	desc = _desc;
	args = _args;
	out = _out;
	print = function() {
		return string(
@"operator: {0}
	{1}
	args: {2}
	output: {3}", name, desc, args, out
		)
	}
}

function RunGML_Op(_f, _doc) constructor {
	f = _f
	doc = _doc
	name = struct_get(doc, "name")
	help = function() {
		return doc.print();
	}
}

//function RunGML_Error(_error) constructor {
//	error = _error;
//}

//function RunGML_Error_InvalidOp(_error) : RunGML_Error(_error) constructor {
//	error = string("{0} is not a valid RunGML operator. Try typing 'help'", _error)
//}

global.RunGML_Ops = {
	"version": new RunGML_Op(
		"2025_02_23_0",
		new RunGML_OpDoc(
			"version",
			"Returns the current RunGML version number",
			"[]",
			"string"
		)
	),
	"update": new RunGML_Op(
		"https://snail-dream.itch.io/RunGML",
		new RunGML_OpDoc(
			"version",
			"Returns the current RunGML version number",
			"[]",
			"string"
		)
	),
	"op_count": new RunGML_Op(
		function(_i, _l=[]) {
			return struct_names_count(_i.language);
		},
		new RunGML_OpDoc(
			"op_count",
			"Returns the number of supported operators",
			"[]",
			"number"
		)
	),
	"op_list": new RunGML_Op(
		function(_i, _l=[]) {
			return struct_get_names(_i.language);
		},
		new RunGML_OpDoc(
			"op_list",
			"Returns a list of supported operators",
			"[]",
			"[names]"
		)
	),
	"help": new RunGML_Op(
		function(_i, _l=[]) {
			if array_length(_l) > 0 {
				var _op = struct_get(_i.language, _l[0])
				if !is_instanceof(_op, RunGML_Op){
					return string("{0} is not a valid RunGML operator. Try \"help\".", _l[0])
				}
				return _op.help();
			} else {
				return _i.run(
					["string", @'
RunGML_Help_BEGIN
		
RunGML is a Lisp-like language embedded in GameMaker Language, with programs written in JSON

This is version {0}
To check for updates, report bugs, or request features, visit {1}

The following {2} operators are currently supported:
{3}

Basic Guide:
1. Create an instance of the interpreter:
RunGMLI = new RunGML_Interpreter("Nickname");

2. Run a program:
RunGMLI.run(["print", "Hello, world"])

3. Retrieve output from a program:
var _output = RunGMLI.run(["return",
	["add", 2, 3]
]

4. Run a program from a file:
RunGMLI.run(["runfile", "/path/to/program.txt"])

RunGML_Help_END
', 
						["version"],
						["update"],
						["op_count"],
						["op_list"]
					]
				)
			}	
		}, new RunGML_OpDoc (
			"help",
			"Displays documentation for RunGML, or for ",
			"[]",
			"[]"
		)
	),
	"pass": new RunGML_Op (
		function(_i, _l=[]) {
			return [];
		},
		new RunGML_OpDoc (
			"pass",
			"Does nothing.",
			"[]",
			"[]"
		)
	),
	"run": new RunGML_Op (
		function(_i, _l) {
			return _i.run(_l);
		}, new RunGML_OpDoc (
			"run",
			"Runs its arguments as a program, treating the first argument as an operator.",
			"[]",
			"[]"
		)
	),
	"out": new RunGML_Op (
		function(_i, _l) {
			return {"out": _l};
		}, new RunGML_OpDoc (
			"out",
			"Wraps its argument list in a dict so it can be returned unevaluated.",
			"[]",
			"[]"
		)
	),
	"last": new RunGML_Op (
		function(_i, _l) {
			var _n = array_length(_l);
			if _n > 0 return _l[_n - 1];
			return [];
		}, new RunGML_OpDoc (
			"last",
			"Returns the value of its last argument",
			"[]",
			"[]"
		)
	),
	"in": new RunGML_Op (
		function(_i, _l) {
			return struct_get(_l[0], "out");
		}, new RunGML_OpDoc (
			"in",
			"Retrieves the output list from a dict produced by the \"out\" operator.",
			"[]",
			"[]"
		)
	),
	
	"import": new RunGML_Op (
		function(_i, _l) {
			if !file_exists(_l[0]) return [];
			var _file = file_text_open_read(_l[0]);
			var _json_string = "";
			while (!file_text_eof(_file)) {
				_json_string += file_text_read_string(_file);
				file_text_readln(_file);
			}
			file_text_close(_file);
			return json_parse(_json_string);
		}, new RunGML_OpDoc (
			"import",
			"Imports JSON from a file",
			"[path]",
			"[]"
		)
	),
	"runfile": new RunGML_Op (
		function(_i, _l) {
			var _prog = _i.run(["import", _l[0]]);
			return _i.run(_prog)
		}, new RunGML_OpDoc (
			"runfile",
			"Runs a program from a file",
			"[path]",
			"[]"
		)
	),
	"export": new RunGML_Op (
		function(_i, _l) {
			var _file = file_text_open_write(_l[0]);
			var _pretty = true;
			if array_length(_l) > 2 {
				_pretty = _l[2];	
			}
			var _json_string = json_stringify(_l[1], _pretty);
			file_text_write_string(_file, _json_string);
			file_text_close(_file);
			return []
		}, new RunGML_OpDoc (
			"export",
			"Exports JSON to a file",
			"[path, data]",
			"[]"
		),
	),
	"noone": new RunGML_Op (
		noone,
		new RunGML_OpDoc (
			"noone",
			"Returns the GameMaker constant noone",
			"[]",
			"[]"
		)
	),
	"undefined": new RunGML_Op (
		undefined,
		new RunGML_OpDoc (
			"undefined",
			"Returns the GameMaker constant undefined",
			"[]",
			"[]"
		)
	),
	"list": new RunGML_Op (
		function(_i, _l=[]) {
			return _l;
		}, new RunGML_OpDoc (
			"list",
			"Returns its arguments as a list",
			"[]",
			"[]"
		)
	),
	"prog": new RunGML_Op (
		function(_i, _l=[]) {
			for (var _line=0; _line<array_length(_l); _line++) {
				_i.run(_l[_line]);
			}
			return [];
		}, new RunGML_OpDoc (
			"prog",
			"Runs its arguments as programs",
			"[]",
			"[]"
		)
	),
	"print": new RunGML_Op (
		function(_i, _l) {
			for(var i=0; i<array_length(_l); i++) {
				show_debug_message(_l[i]);
			}
			return [];
		}, new RunGML_OpDoc (
			"print",
			"Prints a debug message",
			"[string]",
			"[]"
		)
	),
	"string": new RunGML_Op (
		function(_i, _l) {
			var _s = array_shift(_l);
			return string_ext(_s, _l);
		},  new RunGML_OpDoc (
			"",
			"",
			"[template, (var0), ...]",
			"[string]"
		)
	),
	"r": new RunGML_Op (
		function(_i, _l) {
			// Reads a register
			// 0: index
			if _l[0] >= array_length(_i.registers) {
				return undefined;
			}
			return _i.registers[_l[0]];
		}, new RunGML_OpDoc (
			"",
			"",
			"[index]",
			"[value]"
		)
	),
	"s": new RunGML_Op(
		function(_i, _l) {
			// Sets a register
			// 0: index
			// 1: value
			while(_l[0] >= array_length(_i.registers)) {
				array_push(_i.registers, undefined);
			}
			_i.registers[_l[0]] = _l[1];
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"add": new RunGML_Op(
		function(_i, _l) {
			// a, b
			return _l[0] + _l[1];
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_add": new RunGML_Op(
		function(_i, _l) {
			return _i.registers[_l[0]] + _i.registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"sub": new RunGML_Op(
		function(_i, _l) {
			// a, b
			return _l[0] - _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_sub": new RunGML_Op(
		function(_i, _l) {
			return _i.registers[_l[0]] - _i.registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"mult": new RunGML_Op(
		function(_i, _l) {
			// a, b
			return _l[0] * _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_mult": new RunGML_Op(
		function(_i, _l) {
			return _i.registers[_l[0]] * _i.registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"div": new RunGML_Op(
		function(_i, _l) {
			//a, b
			return _l[0] / _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_div": new RunGML_Op(
		function(_i, _l) {
			return registers[_l[0]] / registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"pow": new RunGML_Op(
		function(_i, _l) {
			return power(_l[0], _l[1]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_pow": new RunGML_Op(
		function(_i, _l) {
			return power(registers[_l[0]], registers[[_l[1]]]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_eq": new RunGML_Op(
		function(_i, _l) {
			return registers[_l[0]] == registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_lt": new RunGML_Op(
		function(_i, _l) {
			return registers[_l[0]] < registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_gt": new RunGML_Op(
		function(_i, _l) {
			return registers[_l[0]] > registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_leq": new RunGML_Op(
		function(_i, _l) {
			return registers[_l[0]] <= registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_geq": new RunGML_Op(
		function(_i, _l) {
			return registers[_l[0]] >= registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"r_neq": new RunGML_Op(
		function(_i, _l) {
			return registers[_l[0]] != registers[_l[1]];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"g_get": new RunGML_Op(
		function(_i, _l) {
			// variable
			return variable_global_get(_l[0]);	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"g_set": new RunGML_Op(
		function(_i, _l) {
			// variable, value
			variable_global_set(_l[0], _l[1]);	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"i_get": new RunGML_Op(
		function(_i, _l) {
			// instance, variable
			return variable_instance_get(_l[0], _l[1]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"i_set": new RunGML_Op(
		function(_i, _l) {
			// instance, variable, value
			if instance_exists(_l[0]) {
				variable_instance_set(_l[0], _l[1], _l[2]);
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"inst_create_layer": new RunGML_Op(
		function(_i, _l) {
			// x, y, layer, object_index
			return instance_create_layer(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
		}, new RunGML_OpDoc (
	
		)
	),
	"inst_create_depth": new RunGML_Op(
		function(_i, _l) {
			// x, y, layer, object_index
			return instance_create_depth(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"destroy": new RunGML_Op(
		function(_i, _l) {
			instance_destroy(_l[0]);
		}, new RunGML_OpDoc (
	
		)
	),
	"and": new RunGML_Op(
		function(_i, _l) {
			return _l[0] and _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"or": new RunGML_Op(
		function(_i, _l) {
			return _l[0] or _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"not": new RunGML_Op(
		function(_i, _l) {
			return not _l[0];
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"eq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] == _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"lt": new RunGML_Op(
		function(_i, _l) {
			return _l[0] < _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"gt": new RunGML_Op(
		function(_i, _l) {
			return _l[0] > _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"leq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] <= _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"geq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] >= _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"neq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] != _l[1];	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"clamp": new RunGML_Op(
		function(_i, _l) {
			// val, min, max
			return clamp(_l[0], _l[1], _l[2]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"approach": new RunGML_Op(
		function(_i, _l) {
			// current, change, min, max
			var _val = _l[0] + _l[1];
			if !is_undefined(_l[2]) _val = max(_val, _l[2]);
			if !is_undefined(_l[3]) _val = min(_val, _l[3]);
			return _val;
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"room_w": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return room_width;	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"room_h": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return room_height;
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"display_w": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return display_get_width();	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"display_h": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return display_get_height;
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"struct_get": new RunGML_Op(
		function(_i, _l) {
			// struct, variable
			return struct_get(_l[0], _l[1]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"struct_set": new RunGML_Op(
		function(_i, _l) {
			// struct, variable, value
			struct_set(_l[0], _l[1], _l[2]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"struct_size": new RunGML_Op(
		function(_i, _l) {
			// struct, variable
			return struct_names_count(_l[0]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"struct_keys": new RunGML_Op(
		function(_i, _l) {
			// struct, variable
			return struct_get_names(_l[0]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"if": new RunGML_Op(
		function(_i, _l) {
			// condition, true_func, false_func
			if(_l[0]) {
				if struct_exists(_l[1], "true") {
					_i.run(struct_get(_l[1], "true"));
				}
			} else {
				if struct_exists(_l[1], "false") {
					_i.run(struct_get(_l[1], "false"));
				}
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"switch": new RunGML_Op(
		function(_i, _l) {
			// value, case_dict
			if struct_exists(_l[1], _l[0]){
				_i.run(struct_get(_l[1], _l[0]));	
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"while": new RunGML_Op(
		function(_i, _l) {
			// condition, func
			while(_i.run(_l[0])) {
				_i.run(struct_get(_l[1], "do"));
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"repeat": new RunGML_Op(
		function(_i, _l) {
			// count, func
			for (var i=0; i<_l[0]; i++) {
				_i.run(struct_get(_l[1], "do"));
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"draw_text": new RunGML_Op(
		function(_i, _l) {
			// x, y, string
			draw_text(_l[0], _l[1], _l[2]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"draw_sprite": new RunGML_Op(
		function(_i, _l) {
			// sprite, frame, x, y
			draw_sprite(_l[0], _l[1], _l[2], _l[3]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"draw_sprite_general": new RunGML_Op(
		function(_i, _l) {
			// sprite, frame, left, top, width, height, x, y, xscale, yscale, rot, c1, c2, c3, c4, alpha
			draw_sprite_general(_l[0], _l[1], _l[2], _l[3], _l[4], _l[5], _l[6], _l[7], _l[8], _l[9], _l[10], _l[11], _l[12], _l[13], _l[14], _l[15])	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"object": new RunGML_Op(
		function(_i, _l) {
			var _inst = instance_create_layer(_l[0], _l[1], _l[2], oRunGML_ObjectTemplate);
			_inst.event_dict = _l[3]
			_inst.run_event("create")
			return _inst;
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"draw_set_color": new RunGML_Op(
		function(_i, _l) {
			draw_set_color(_l[0]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"draw_set_alpha": new RunGML_Op(
		function(_i, _l) {
			draw_set_alpha(_l[0]);
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"draw_set_halign": new RunGML_Op(
		function(_i, _l) {
			switch(_l[0]) {
				case "left":
				case -1:
					draw_set_halign(fa_left);
					break;
				case "right":
				case 1:
					draw_set_halign(fa_right);
					break;
				case "center":
				case 0:
					draw_set_halign(fa_center);
					break;
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"draw_set_valign": new RunGML_Op(
		function(_i, _l) {
			switch(_l[0]) {
				case "top":
				case -1:
					draw_set_halign(fa_top);
					break;
				case "bottom":
				case 1:
					draw_set_halign(fa_bottom);
					break;
				case "middle":
				case 0:
					draw_set_halign(fa_middle);
					break;
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"rgb": new RunGML_Op(
		function(_i, _l) {
			return make_color_rgb(_l[0], _l[1], _l[2]);	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"hsv": new RunGML_Op(
		function(_i, _l) {
			return make_color_hsv(_l[0], _l[1], _l[2]);	
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"fps": new RunGML_Op(
		function(_i, _l) {
			return fps;
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"nth": new RunGML_Op(
		function(_i, _l) {
			switch(_l[0] mod 10){
				case 1:
					return "st"
				case 2:
					return "nd"
				default:
					return "rd"
			}
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"console": new RunGML_Op(
		function(_i, _l) {
			if !instance_exists(oRunGML_Console) {
				global.RunGML_Console = instance_create_depth(0, 0, 0, oRunGML_Console);
			}
			return global.RunGML_Console
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"quit": new RunGML_Op(
		function(_i, _l) {
			game_end();
		}, new RunGML_OpDoc (
			"",
			"",
			"[]",
			"[]"
		)
	),
}


// Interpreter
function RunGML_Interpreter(_name="RunGML_I") constructor {
	name = _name;
	debug = global.RunGML_I_debug;
	language = global.RunGML_Ops;
	registers = [];
	recursion = 0;
	
	run = function(_l) {
		if array_length(_l) < 1 return;
		recursion += 1
		if debug show_debug_message(@"RunGML_I:{0}[{1}].run({2})", name, recursion, _l);
		
		for (var i=0; i<array_length(_l); i++) {
			if typeof(_l[i]) == "array" {
				_l[i] = run(_l[i]);
			}
		}
		
		if !struct_exists(language, _l[0]) return _l;
		var _operator = array_shift(_l);
		var _op = struct_get(language, _operator);
		if debug show_debug_message(@"RunGML_I:{0}[{1}].exec({2}({3}))", name, recursion, _operator, _l);
		var _op_func = struct_get(_op, "f");
		var _out = _op_func;
		if typeof(_op_func) = "method" {
			_out = script_execute(_op_func, self, _l);
		}
		recursion -= 1;
		return _out;
	}
}