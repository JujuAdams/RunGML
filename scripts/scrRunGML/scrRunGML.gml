global.RunGML_homepage = "https://snail-dream.itch.io/RunGML"

function RunGML_Doc(_name="RunGML Operator", _desc="Description", _args="[]", _out="[]") constructor {
	name = _name;
	desc = _desc;
	args = _args;
	out = _out;
	print = function() {
		return string(
@"- {0}
    - {1}
    - args: {2}
    - output: {3}", name, desc, args, out
		)
	}
}

function RunGML_Constraint() constructor {
	check = function(_l) {return true};
}

function RunGML_Constraint_ArgCount(_op="eq", _count=noone, _warn=true) : RunGML_Constraint() constructor {
	count = _count
	op = _op
	warn = _warn;
	err_msg = @"
ArgCount constraint violated
	args: {0}
	count: {1}
	check: {2}"
	doc = function() {return string("? {0} {1}", op, count)}
	check = function(_l) {
		var _valid;
		switch(op) {
			case "eq":
				_valid = array_length(_l) == count;
				break;
			case "nq":
				_valid = array_length(_l) != count;
				break;
			case "gt":
				_valid = array_length(_l) > count;
				break;
			case "geq":
				_valid = array_length(_l) >= count;
				break;
			case "lt":
				_valid = array_length(_l) < count;
				break;
			case "leq":
				_valid = array_length(_l) <= count;
				break;
			case "choose":
				_valid = array_contains(count, array_length(_l));
				break;
		}
		if !_valid and warn show_debug_message(string(err_msg, _l, array_length(_l), doc()))
		return _valid;
	}
}

function RunGML_Constraint_ArgType(_indexes=[], _types=noone, _warn=true): RunGML_Constraint() constructor {
	indexes = _indexes;
	types = _types;
	if types == "numeric" types = ["number", "int32", "int64"]
	warn = _warn;
	doc = function() {return string("indexes: {0}\nvalid types: {1}", indexes, types)}
	err_msg = @"
ArgType constraint violated
	args: {0}
	bad index: {1}
	bad value type: {2}
	valid types: {3}"
	
	check = function(_l) {
		if types == noone return true;
		var _index, _val, _type;
		if indexes == "all" {
			for (var i=0; i<array_length(_l); i++) {
				_val = _l[i];
				_type = typeof(_val);
				if not array_contains(types, _type) {
					if warn show_debug_message(string(err_msg, _l, i, _type, types));
					return false;
				}
			}
		} else {
			for (var i=0; i<array_length(indexes); i++) {
				_index = indexes[1];
				if _index >= array_length(_l) {
					if warn show_debug_message("An ArgType constraint was expecting at least {0} arguments, but only got {1}", _index, array_length(_l));
					return false;
				}
				_val = _l[_index];
				_type = typeof(_val)
				if not array_contains(types, _type){
					if warn show_debug_message(string(err_msg, _l, _index, _type, types));
					return false;
				}
			}
		}
		return true;
	}
}

function RunGML_Op(_f, _doc, _constraints=[]) constructor {
	f = _f;
	doc = _doc;
	constraints = _constraints;
	name = struct_get(doc, "name");
	help = function() {
		return doc.print();
	}
	
	valid = function(_l) {
		var _constraint, _valid;
		for(var i=0; i<array_length(constraints); i++) {
			_constraint = constraints[i];
			
			_valid = constraints[i].check(_l)
			if !_valid {
				var _err = new RunGML_Error_InvalidArgs(name)
				_err.warn();
				return false;
			}
		}
		return true;
	}
}

function RunGML_Error(_msg="") constructor {
	msg = "RunGML_Error: " + string(_msg);
	warn = function() {
		show_debug_message(msg);
	}
}

function RunGML_Error_InvalidArgs(_op) : RunGML_Error() constructor {
	msg = string("	operator: {0}", _op);
}

/* Operator Definitions
Additional operators should be defined in scrRunGML_Config
Make backup of that file before updating RunGML
Then you can restore your custom settings and operators after updating
*/
global.RunGML_Ops = {
	#region Metadata
	"version": new RunGML_Op(
		"2025_03_04_0",
		new RunGML_Doc(
			"version",
			"Returns the RunGML version number",
			"[]",
			"string"
		)
	),
	"gm_version": new RunGML_Op(
		GM_version,
		new RunGML_Doc(
			"gm_version",
			"Returns the game's version number",
			"[]",
			"string"
		)
	),
	"update": new RunGML_Op(
		function(_i, _l=[]) {
			url_open(global.RunGML_homepage);
			return [];
		},
		new RunGML_Doc(
			"update",
			"Returns the RunGML web address",
			"[]",
			"string"
		)
	),
	"op_count": new RunGML_Op(
		function(_i, _l=[]) {
			return struct_names_count(_i.language);
		},
		new RunGML_Doc(
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
		new RunGML_Doc(
			"op_list",
			"Returns a list of supported operators",
			"[]",
			"[string, *]"
		)
	),
	"op_names": new RunGML_Op(
		function(_i, _l=[]) {
			var _op_list = struct_get_names(_i.language);
			var _str = "";
			for (var i=0; i<array_length(_op_list); i++) {
				if i > 0 _str += ", ";
				_str += _op_list[i];
			}
			return _str;
		},
		new RunGML_Doc(
			"op_names",
			"Returns a string listing names of supported operators",
			"[]",
			"string"
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
# RunGML

Version: {0}
Homepage: {1}

RunGML is a runtime scripting language embedded in GameMaker Language.

It has a Lisp-like structure of nested lists, with a JSON-compatible syntax.

You can use it to provide modding support, encrypt secret content, or make arbitrary changes to your game while it runs.

Be warned: the syntax prioritizes concision over readability, and the implemenation prioritizes flexibility over safety.

Use at your own risk.

Run ["update"] to visit the homepage and check for updates, report bugs, or request features.

The following {2} operators are currently supported: {3}

Try running ["help", "some_operator_name"] to get documentation on a specific operator.

Or run ["manual"] to display full documentation for all operators.
', 
						["version"],
						["global", "RunGML_homepage"],
						["op_count"],
						["op_names"]
					]
				)
			}	
		}, new RunGML_Doc (
			"help",
			"Display documentation for RunGML, or for an operator named by the first argument.",
			"[(string)]",
			"string"
		)
	),
	"manual": new RunGML_Op (
		function(_i, _l) {
			var _filename = "RunGML/manual.md";
			if array_length(_l) > 0 _filename = _l[0];
			if file_exists(_filename) file_delete(_filename);
			var _f = file_text_open_append(_filename)
			var _ops = variable_struct_get_names(_i.language);
			var _op;
			file_text_write_string(_f, _i.run(["help"]));
			file_text_write_string(_f, "\n\n# Operators\n\n");
			for (var i=0; i<array_length(_ops); i++) {
				_op = struct_get(_i.language, _ops[i])
				file_text_write_string(_f, "\n"+_op.help()+"\n")
			}
			file_text_close(_f);
			url_open(_filename)
			return [];
		}, new RunGML_Doc (
			"manual",
			"Write full documentation for the RunGML language to a file in the save directory.",
			"[(filename)]",
			"[]"
		)
	),
	"this": new RunGML_Op (
		function(_i, _l) {
			return _i;
		}, new RunGML_Doc (
			"this",
			"Return a reference to the current RunGML interpreter",
			"[]",
			"instance"
		)
	),
	"parent": new RunGML_Op(
		function(_i, _l) {
			return _i.parent
		}, new RunGML_Doc (
			"console",
			"Return a reference to the RunGML interpreter's parent object.",
			"[]",
			"instance"
		)
	),
	"console": new RunGML_Op(
		function(_i, _l) {
			if !instance_exists(oRunGML_Console) {
				global.RunGML_Console = instance_create_depth(0, 0, 0, oRunGML_Console);
			}
			return global.RunGML_Console
		}, new RunGML_Doc (
			"console",
			"Returns a reference to the RunGML console, creating one if it doesn't exist",
			"[]",
			"instance"
		)
	),
	"clear": new RunGML_Op(
		function(_i, _l) {
			if object_get_name(variable_instance_get(_i.parent, "object_index")) == "oRunGML_Console" {
				_i.parent.clear_history();
			}
			return [];
		}, new RunGML_Doc (
			"clear",
			"If run from a console, clear that console's history",
			"[]",
			"instance"
		)
	),
	#endregion Metadata
	
	#region Control Flow
	"pass": new RunGML_Op (
		function(_i, _l=[]) {
			return [];
		},
		new RunGML_Doc (
			"pass",
			"Do nothing.",
			"[*]",
			"[]"
		)
	),
	"run": new RunGML_Op (
		function(_i, _l) {
			return _i.run(_l);
		}, new RunGML_Doc (
			"run",
			"Run arguments as a program.",
			"[*]",
			"*"
		)
	),
	"exec": new RunGML_Op (
		function(_i, _l) {
			return _i.run(json_parse(_l[0]));
		}, new RunGML_Doc (
			"exec",
			"Execute a string as a program.",
			"[string]",
			"*"
		), [new RunGML_Constraint_ArgCount("eq", 1)]
	),
	"last": new RunGML_Op (
		function(_i, _l) {
			var _n = array_length(_l);
			if _n > 0 return _l[_n - 1];
			return [];
		}, new RunGML_Doc (
			"last",
			"Return the value of the last argument",
			"[*]",
			"*"
		)
	),
	"out": new RunGML_Op (
		function(_i, _l) {
			return {"out": _l};
		}, new RunGML_Doc (
			"out",
			"Wrap argument list in a struct so it can be returned unevaluated.",
			"[*]",
			"struct"
		)
	),
	"in": new RunGML_Op (
		function(_i, _l) {
			return struct_get(_l[0], "out");
		}, new RunGML_Doc (
			"in",
			"Retrieve the output list from a struct produced by the \"out\" operator.",
			"[struct]",
			"list"
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
		}, new RunGML_Doc (
			"import",
			"Import JSON from a file",
			"[string]",
			"json"
		)
	),
	"runfile": new RunGML_Op (
		function(_i, _l) {
			return _i.run([
				["run", ["import", _l[0]]]
			])
		}, new RunGML_Doc (
			"runfile",
			"Run a program from a file",
			"[string]",
			"*"
		)
	),
	"runprog": new RunGML_Op (
		function(_i, _l) {
			return _i.run([
				["run", ["import", ["string", "RunGML/programs/{0}.txt", _l[0]]]]
			])
		}, new RunGML_Doc (
			"runprog",
			"Run a program from a file in the incdlued RunGML/programs directory",
			"[string]",
			"*"
		)
	),
	"example": new RunGML_Op (
		function(_i, _l) {
			return _i.run(["run", ["import", ["string", "RunGML/programs/examples/{0}.txt", _l[0]]]])
		}, new RunGML_Doc (
			"example",
			"Run an included example program",
			"[string]",
			"*"
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
		}, new RunGML_Doc (
			"export",
			"Export JSON to a file",
			"[path, data]",
			"[]"
		),
	),
	"list": new RunGML_Op (
		function(_i, _l=[]) {
			return _l;
		}, new RunGML_Doc (
			"list",
			"Return arguments as a list",
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
		}, new RunGML_Doc (
			"prog",
			"Run arguments as programs",
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
		}, new RunGML_Doc (
			"if",
			"Evaluate and act on a conditional",
			"[conditional, {('true': function), ('false': function)}]",
			"[]"
		)
	),
	"switch": new RunGML_Op(
		function(_i, _l) {
			// value, case_dict
			if struct_exists(_l[1], _l[0]){
				_i.run(struct_get(_l[1], _l[0]));	
			}
		}, new RunGML_Doc (
			"switch",
			"Perform switch/case evaluation",
			"[value, {'case0': function, 'case1': function}]",
			"[]"
		)
	),
	"while": new RunGML_Op(
		function(_i, _l) {
			// condition, func
			while(_i.run(_l[0])) {
				_i.run(struct_get(_l[1], "do"));
			}
		}, new RunGML_Doc (
			"while",
			"Exectue a function while a condition is true",
			"[conditional, {'do': function}]",
			"[]"
		)
	),
	"repeat": new RunGML_Op(
		function(_i, _l) {
			// count, func
			for (var i=0; i<_l[0]; i++) {
				_i.run(struct_get(_l[1], "do"));
			}
		}, new RunGML_Doc (
			"repeat",
			"Repeat a function a fixed number of times",
			"[count, function]",
			"[]"
		)
	),
	
	#endregion Control Flow
	
	#region Constants
	"noone": new RunGML_Op (
		noone,
		new RunGML_Doc (
			"noone",
			"Return the GameMaker constant noone",
			"[]",
			"noone"
		)
	),
	"undefined": new RunGML_Op (
		undefined,
		new RunGML_Doc (
			"undefined",
			"Return the GameMaker constant undefined",
			"[]",
			"undefined"
		)
	),
	#endregion Constants
	
	#region Debugging
	"print": new RunGML_Op (
		function(_i, _l) {
			for(var i=0; i<array_length(_l); i++) {
				show_debug_message(_l[i]);
			}
			return [];
		}, new RunGML_Doc (
			"print",
			"Print a debug message",
			"[string]",
			"[]"
		)
	),
	#endregion Debugging
	
	#region Text
	"string": new RunGML_Op (
		function(_i, _l) {
			var _s = array_shift(_l);
			return string_ext(_s, _l);
		},  new RunGML_Doc (
			"string",
			"Perfors string formatting",
			"[template, (var0), ...]",
			"[string]"
		)
	),
	"draw_text": new RunGML_Op(
		function(_i, _l) {
			// x, y, string
			draw_text(_l[0], _l[1], _l[2]);
		}, new RunGML_Doc (
			"draw_text",
			"Draw text",
			"[x, y, string]",
			"[]"
		)
	),
	#endregion Types
		
	#region Accessors
	"v": new RunGML_Op (
		function(_i, _l) {
			if array_length(_l) == 0 return _i.registers;
			else if array_length(_l) == 1 {
				if struct_exists(_i.registers, _l[0]) {
					return struct_get(_i.registers, _l[0]);
				}
				else return undefined;
			} else {
				struct_set(_i.registers, _l[0], _l[1]);
				return [];
			}
		}, new RunGML_Doc (
			"v",
@"Get and set variables.  Behavior changes based on number of arguments:
0: Returns the interpreter's entire registers struct.
1: Returns the value saved in the named register.
2: Sets the register named by the first argument to the value of the second argument.
",
			"[int] or [string]",
			"*"
		)
	),
	"r": new RunGML_Op (
		function(_i, _l) {
			if array_length(_l) == 0 return _i.registers;
			if struct_exists(_i.language, _l[0]) {
				for (var i=1; i<array_length(_l); i++) {
					_l[i] = struct_get(_i.registers, _l[i]);
				}
				return run(_l);
			}
			else return undefined;
		}, new RunGML_Doc (
			"r",
@"The register operator.
If no arguments are provided, returns the interpreter's registers struct
If the first argument names an operator, replaces any other integer arguments with the corresponding register values and runs that operator on the resulting list.
For example, the following two programs are functionally equivalent:
	['r', 'add', 0, 1]
	['add', ['g', 0], ['g', 1]]
They will return the sum of the values in registers 0 and 1.
",
			"[index] or [operator, index0, index1, ...]",
			"[value] or the rusult of applying the named operator"
		)
	),
	"global": new RunGML_Op(
		function(_i, _l) {
			switch(array_length(_l)) {
				case 0:
					return variable_instance_get_names(global);
					break;
				case 1: 
					return variable_global_get(_l[0]);
					break;
				case 2:
				default:
					variable_global_set(_l[0], _l[1]);
					return [];
					break;
			}
		}, new RunGML_Doc (
			"global",
@"Create, read, or modify global variables.
Behavior depends on the number of arguments:
	0: return an empty struct
	1: returns {'struct': arg0}
	2: returns get_struct(arg0, arg1)
",
			"[]",
			"[]"
		)
	),
	"inst": new RunGML_Op(
		function(_i, _l) {
			switch(array_length(_l)) {
				case 1:
					return variable_instance_get_names(_l[0]);
					break;
				case 2:
					return variable_instance_get(_l[0], _l[1]);
					break;
				case 3:
					variable_instance_set(_l[0], _l[1], _l[2]);
					return [];
					break;
				default:
					return undefined;
					break;
			}
		}, new RunGML_Doc (
			"inst",
@"Get and set instance variables.
Behavior depends on the number of arguments:
	2: returns variable_instance_get(arg0, arg1)
	3: does variable_instance_set(arg0, arg1, arg2)
",
			"[instance, index, (value)]",
			"*"
		)
	),
	"struct": new RunGML_Op(
		function(_i, _l) {
			// struct, variable
			switch(array_length(_l)) {
				case 0:
					return {}
					break;
				case 1: 
					return {"struct": _l}
					break;
				case 2:
					return struct_get(_l[0], _l[1]);
					break;
				case 3:
				default:
					struct_set(_l[0], _l[1], _l[2]);
					return [];
					break;
			}
		}, new RunGML_Doc (
			"struct",
@"Create, read, or modify a struct.
Behavior depends on the number of arguments:
	0: return an empty struct
	1: returns {'struct': arg0}
	2: returns get_struct(arg0, arg1)
	3: returns set_struct(arg0, arg1, arg2);
",
			"[]",
			"[]"
		)
	),
	"struct_keys": new RunGML_Op(
		function(_i, _l) {
			// struct, variable
			return struct_get_names(_l[0]);
		}, new RunGML_Doc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	"array": new RunGML_Op(
		function(_i, _l) {
			// (array), (index), (value)
			switch(array_length(_l)) {
				case 0:
					return [];
					break;
				case 1: 
					return _l;
					break;
				case 2:
					if _l[1] < array_length(_l[0]) return undefined;
					return _l[0][_l[1]];
					break;
				case 3:
				default:
					while array_length(_l[0]) <= _l[1] {
						array_push(_l[0], undefined);
					}
					_l[0][_l[1]] = _l[2];
					return [];
					break;
			}
		}, new RunGML_Doc (
			"array",
@"Create, read, or modify a struct.
Behavior depends on the number of arguments:
	0: return an empty array
	1: returns [arg0]
	2: returns arg0[arg1]
	3: sets arg0[arg1] = arg2;
",
			"[(array), (index), (value)]",
			"[*]"
		)
	),
	
	"len": new RunGML_Op(
		function(_i, _l) {
			// struct, variable
			switch(typeof(_l[0])) {
				case "struct":
					return struct_names_count(_l[0]);
				case "array":
					return array_length(_l[0]);
				case "string":
					return string_length(_l[0]);
				default:
					return undefined;
			}
		}, new RunGML_Doc (
			"len",
			"Returns the length of a string, array, or struct.",
			"[string/array/struct]",
			"length"
		)
	),
	#endregion Accessors
	
	#region Math
	"add": new RunGML_Op(
		function(_i, _l) {
			// a, b
			return _l[0] + _l[1];
		}, new RunGML_Doc (
			"add",
			"Add two numbers",
			"[A, B]",
			"A + B"
		)
	),
	"sub": new RunGML_Op(
		function(_i, _l) {
			// a, b
			return _l[0] - _l[1];	
		}, new RunGML_Doc (
			"sub",
			"Subtract two numbers",
			"[A, B]",
			"A - B"
		), [
			new RunGML_Constraint_ArgCount("eq", 2),
			new RunGML_Constraint_ArgType("all", "numeric")
		]
	),
	"mult": new RunGML_Op(
		function(_i, _l) {
			// a, b
			return _l[0] * _l[1];	
		}, new RunGML_Doc (
			"mult",
			"Multiply two numbers",
			"[A, B]",
			"A * B"
		)
	),
	"div": new RunGML_Op(
		function(_i, _l) {
			//a, b
			return _l[0] / _l[1];	
		}, new RunGML_Doc (
			"div",
			"Divide two numbers",
			"[A, B]",
			"A / B"
		)
	),
	"pow": new RunGML_Op(
		function(_i, _l) {
			return power(_l[0], _l[1]);
		}, new RunGML_Doc (
			"pow",
			"Raise one number to the power of another",
			"[A, B]",
			"A ^ B"
		)
	),
	"clamp": new RunGML_Op(
		function(_i, _l) {
			return clamp(_l[0], _l[1], _l[2]);
		}, new RunGML_Doc (
			"clamp",
			"Clamp a number between a minimum and maximum value",
			"[number, min, max]",
			"number"
		)
	),
	"approach": new RunGML_Op(
		function(_i, _l) {
			var _val = _l[0] + _l[1];
			_val = clamp(_val, _l[2], _l[3]);
			return _val;
		}, new RunGML_Doc (
			"approach",
			"Increment a number by some amount while staying within a range",
			"[number, increment, min, max]",
			"[number]"
		)
	),
	#endregion Math
	
	#region Objects
	"object": new RunGML_Op(
		function(_i, _l) {
			var _inst = instance_create_layer(_l[0], _l[1], _l[2], oRunGML_ObjectTemplate);
			_inst.event_dict = _l[3]
			_inst.run_event("create")
			return _inst;
		}, new RunGML_Doc (
			"object",
			"Create a new oRunGML_Object instance and return its index",
			"[x, y, layer_name, event_dictionary]",
			"oRunGML_Object instance"
		)
	),
	"inst_create_layer": new RunGML_Op(
		function(_i, _l) {
			// x, y, layer, object_index
			return instance_create_layer(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
		}, new RunGML_Doc (
			"inst_create_layer",
			"Create a new object on the specified layer",
			"[x, y, layer, object_index]",
			"[instance_id]"
		)
	),
	"inst_create_depth": new RunGML_Op(
		function(_i, _l) {
			// x, y, depth, object_index
			return instance_create_depth(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
		}, new RunGML_Doc (
			"inst_create_depth",
			"Create a new object at the specified depth",
			"[x, y, depth, object_index]",
			"[instance_id]"
		)
	),
	"destroy": new RunGML_Op(
		function(_i, _l) {
			instance_destroy(_l[0]);
		}, new RunGML_Doc (
			"destroy",
			"Destroy an instance",
			"[instance_id]",
			"[]"
		)
	),
	#endregion Objects
	
	#region Logic
	"and": new RunGML_Op(
		function(_i, _l) {
			return _l[0] and _l[1];	
		}, new RunGML_Doc (
			"and",
			"Returns true iff both arguments are true",
			"[A, B]",
			"[(A and B)]"
		)
	),
	"or": new RunGML_Op(
		function(_i, _l) {
			return _l[0] or _l[1];	
		}, new RunGML_Doc (
			"or",
			"Returns true if either argument is true",
			"[A, B]",
			"[(A or B)]"
		)
	),
	"not": new RunGML_Op(
		function(_i, _l) {
			return not _l[0];
		}, new RunGML_Doc (
			"not",
			"Returns the inverse of the argument's boolean value",
			"[A]",
			"[!A]"
		)
	),
	"eq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] == _l[1];	
		}, new RunGML_Doc (
			"eq",
			"Returns true iff the two arguments are equal",
			"[A, B]",
			"[(A == B)]"
		)
	),
	"lt": new RunGML_Op(
		function(_i, _l) {
			return _l[0] < _l[1];	
		}, new RunGML_Doc (
			"lt",
			"Returns true iff the first argument is less than the second",
			"[A, B]",
			"[(A < B)]"
		)
	),
	"gt": new RunGML_Op(
		function(_i, _l) {
			return _l[0] > _l[1];	
		}, new RunGML_Doc (
			"gt",
			"Returns true iff the first argument is greater than the second",
			"[A, B]",
			"[(A > B)]"
		)
	),
	"leq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] <= _l[1];	
		}, new RunGML_Doc (
			"leq",
			"Returns true iff the first argument is less than or equal to the second",
			"[A, B]",
			"[(A <= B)]"
		)
	),
	"geq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] >= _l[1];	
		}, new RunGML_Doc (
			"geq",
			"Returns true iff the first argument is greater than or equal to the second",
			"[A, B]",
			"[(A >= B)]"
		)
	),
	"neq": new RunGML_Op(
		function(_i, _l) {
			return _l[0] != _l[1];	
		}, new RunGML_Doc (
			"neq",
			"Returns true iff the two arguments are not equal",
			"[A, B]",
			"[(A != B)]"
		)
	),
	#endregion Logic
	
	#region Rooms
	"room_w": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return room_width;	
		}, new RunGML_Doc (
			"room_w",
			"Returns the width of the current room.",
			"[]",
			"[width]"
		)
	),
	"room_h": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return room_height;
		}, new RunGML_Doc (
			"room_h",
			"Returns the height of the current room.",
			"[]",
			"[height]"
		)
	),
	#endregion Rooms
	
	#region Displays
	"display_w": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return display_get_width();	
		}, new RunGML_Doc (
			"display_w",
			"Returns the width of the display.",
			"[]",
			"[width]"
		)
	),
	"display_h": new RunGML_Op(
		function(_i, _l=[]) {
			//
			return display_get_height;
		}, new RunGML_Doc (
			"display_h",
			"Returns the height of the display.",
			"[]",
			"[height]"
		)
	),
	#endregion Displays
	
	#region Drawing
	"draw_sprite": new RunGML_Op(
		function(_i, _l) {
			// sprite, frame, x, y
			draw_sprite(_l[0], _l[1], _l[2], _l[3]);
		}, new RunGML_Doc (
			"draw_sprite",
			"Draw a sprite",
			"[sprite_index, frame, x, y]",
			"[]"
		)
	),
	"draw_sprite_general": new RunGML_Op(
		function(_i, _l) {
			// sprite, frame, left, top, width, height, x, y, xscale, yscale, rot, c1, c2, c3, c4, alpha
			draw_sprite_general(_l[0], _l[1], _l[2], _l[3], _l[4], _l[5], _l[6], _l[7], _l[8], _l[9], _l[10], _l[11], _l[12], _l[13], _l[14], _l[15])	
		}, new RunGML_Doc (
			"draw_sprite_general",
			"Draw a sprite using additional parameters",
			"[sprite_index, frame, left, top, width, height, x, y, xscale, yscale, rot, c1, c2, c3, c4, alpha]",
			"[]"
		)
	),

	"draw_color": new RunGML_Op(
		function(_i, _l) {
			if array_length(_l) < 1 return draw_get_color();
			draw_set_color(_l[0]);
			return [];
		}, new RunGML_Doc (
			"draw_color",
			"Get or set the draw color.",
			"[(color)]",
			"(color)"
		)
	),
	"draw_alpha": new RunGML_Op(
		function(_i, _l) {
			if array_length(_l) < 1 return draw_get_alpha();
			draw_set_alpha(_l[0]);
			return [];
		}, new RunGML_Doc (
			"draw_alpha",
			"Get or set the draw alpha.",
			"[(alpha)]",
			"(alpha)"
		)
	),
	"draw_halign": new RunGML_Op(
		function(_i, _l) {
			if array_length(_l) < 1 {
				return draw_get_halign();	
			} else {
				switch(_l[0]) {
					case "left":
					case fa_left:
					case -1:
						draw_set_halign(fa_left);
						break;
					case "right":
					case fa_right:
					case 1:
						draw_set_halign(fa_right);
						break;
					case "center":
					case fa_center:
					case 0:
						draw_set_halign(fa_center);
						break;
				}
				return [];
			}
		}, new RunGML_Doc (
			"draw_halign",
			"Get or set the horizontal draw alignment",
			"[(value)]",
			"(value)"
		)
	),
	"draw_valign": new RunGML_Op(
		function(_i, _l) {
			if array_length(_l) < 1 {
				return draw_get_valign();	
			} else {
				switch(_l[0]) {
					case "top":
					case fa_top:
					case -1:
						draw_set_halign(fa_top);
						break;
					case "bottom":
					case fa_bottom:
					case 1:
						draw_set_halign(fa_bottom);
						break;
					case "middle":
					case fa_middle:
					case 0:
						draw_set_halign(fa_middle);
						break;
				}
				return [];
			}
		}, new RunGML_Doc (
			"draw_valign",
			"Get or set the vertical draw alignment",
			"[(value)]",
			"(value)"
		)
	),
	"rgb": new RunGML_Op(
		function(_i, _l) {
			return make_color_rgb(_l[0], _l[1], _l[2]);	
		}, new RunGML_Doc (
			"rgb",
			"Create an RGB color",
			"[red, green, blue]",
			"color"
		)
	),
	"hsv": new RunGML_Op(
		function(_i, _l) {
			return make_color_hsv(_l[0], _l[1], _l[2]);	
		}, new RunGML_Doc (
			"hsv",
			"Create an HSV color",
			"[hue, saturation, value]",
			"color"
		)
	),
	#endregion Drawing
	
	"fps": new RunGML_Op(
		function(_i, _l) {
			return fps;
		}, new RunGML_Doc (
			"fps",
			"Get the current fps (capped at the room speed)",
			"[]",
			"fps"
		)
	),
	
	"fps_real": new RunGML_Op(
		function(_i, _l) {
			return fps_real;
		}, new RunGML_Doc (
			"fps",
			"Get the current fps (not capped at the room speed)",
			"[]",
			"fps_real"
		)
	),
	"game_speed": new RunGML_Op(
		function(_i, _l) {
			if array_length(_l) > 0 {
				game_set_speed(_l[0], gamespeed_fps);
				return [];
			} else return game_get_speed(gamespeed_fps);
		}, new RunGML_Doc (
			"fps",
			"Get or set the game speed in terms of fps",
			"[(game_speed)]",
			"(game_speed)"
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
		}, new RunGML_Doc (
			"",
			"",
			"[]",
			"[]"
		)
	),
	
	"quit": new RunGML_Op(
		function(_i, _l) {
			game_end();
			return [];
		}, new RunGML_Doc (
			"quit",
			"Quit the game",
			"[]",
			"[]"
		)
	),
	
	"rickroll": new RunGML_Op(
		function(_i, _l) {
			url_open("https://sdlwdr.github.io/rickroll/rickroll.mp4");
			return [];
		}, new RunGML_Doc (
			"rickroll",
			"Do a rickroll!",
			"[]",
			"[]"
		)
	)
}


// Interpreter
function RunGML_Interpreter(_name="RunGML_I") constructor {
	name = _name;
	debug = global.RunGML_I_debug;
	language = global.RunGML_Ops;
	registers = {};
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
		if !struct_exists(language, _l[0]) {
			recursion -= 1;
			return _l;
		}
		var _op_name = array_shift(_l);
		var _op = struct_get(language, _op_name);
		if debug show_debug_message(@"RunGML_I:{0}[{1}].exec({2}({3}))", name, recursion, _op_name, _l);
		if not _op.valid(_l) {
			recursion -= 1;
			return undefined;
		}
		var _op_func = struct_get(_op, "f");
		var _out;
		if typeof(_op_func) == "method" _out = script_execute(_op_func, self, _l);
		else _out = _op_func;
		recursion -= 1;
		return _out;
	}
}

RunGML_Config();