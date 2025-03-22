global.RunGML_homepage = "https://github.com/sdelaughter/RunGML"

function RunGML_Error(_msg="") constructor {
	msg = string("\n### {0} ###\n", instanceof(self));
	msg += string(_msg);
	warn = function() {
		if global.RunGML_throwErrors throw(msg);
		else show_debug_message(msg);
	}
}

function RunGML_Constraint() constructor {
	check = function(_l) {return true}
	doc = function() {return string("true")}
}

function RunGML_Constraint_ArgCount(_op="eq", _count=noone, _warn=true) : RunGML_Constraint() constructor {
	count = _count
	op = _op
	warn = _warn;
	err_msg = @"ArgCount constraint violated
    - args: {0}
    - count: {1}
    - check: {2}"
	doc = function() {return string("ArgCount: ? {0} {1}", op, count)}
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
		if !_valid return new RunGML_Error(string(err_msg, _l, array_length(_l), doc()))
		return _valid;
	}
}

function RunGML_Constraint_ArgType(_indexes=[], _types=noone, _warn=true): RunGML_Constraint() constructor {
	indexes = _indexes;
	types = _types;
	if types == "numeric" types = ["number", "int32", "int64"]
	warn = _warn;
	doc = function() {return string("ArgType: {0} in {1}", indexes, types)}
	err_msg = @"ArgType constraint violated
    - args: {0}
    - bad index: {1}
    - bad value type: {2}
    - valid types: {3}"
	
	check = function(_l) {
		if types == noone return true;
		var _index, _val, _type;
		if indexes == "all" {
			for (var i=0; i<array_length(_l); i++) {
				_val = _l[i];
				_type = typeof(_val);
				if not array_contains(types, _type) {
					return new RunGML_Error(string(err_msg, _l, i, _type, types))
				}
			}
		} else {
			for (var i=0; i<array_length(indexes); i++) {
				_index = indexes[1];
				if _index >= array_length(_l) {
					return new RunGML_Error("An ArgType constraint was expecting at least {0} arguments, but only got {1}", _index, array_length(_l));
				}
				_val = _l[_index];
				_type = typeof(_val)
				if not array_contains(types, _type){
					return new RunGML_Error(string(err_msg, _l, _index, _type, types));
				}
			}
		}
		return true;
	}
}

function RunGML_Op(_name, _f, _doc="", _constraints=[]) constructor {
	if struct_exists(global.RunGML_Ops, _name) and not global.RunGML_Config_overwrite return;

	name = _name;
	f = _f;
	doc = _doc;
	constraints = _constraints;
	help = function() {
		var _docstring = string(@"- {0}: {1}", name, doc);
		var _n_constraints = array_length(constraints);
		if _n_constraints > 0 {
			_docstring += "\n    - constraints:";
			for (var i=0; i<_n_constraints; i++) {
				_docstring += string("\n        - {0}", constraints[i].doc())
			}
		}
		return _docstring;
	}
	
	exec = function(_i, _l) {
		var _out = undefined;
		if valid(_l) {
			if typeof(f) == "method" _out = script_execute(f, _i, _l);
			else _out = f;
		}
		return _out;
	}
	
	valid = function(_l) {
		var _constraint, _err;
		for(var i=0; i<array_length(constraints); i++) {
			_constraint = constraints[i];
			_err = constraints[i].check(_l)
			if is_instanceof(_err, RunGML_Error) {
				_err.msg += string("\n    - operator: {0}", name);
				_err.warn();
				return false;
			}
		}
		return true;
	}

	struct_set(global.RunGML_Ops, name, self);
}

/* Operator Definitions
Additional operators should be defined in scrRunGML_Config
Make backup of that file before updating RunGML
Then you can restore your custom settings and operators after updating
*/

global.RunGML_Ops = {}

#region Metadata

new RunGML_Op("version", "2025_03_04_0",
@"Returns the RunGML version number
    - args: []
    - output: string"
)
	
new RunGML_Op("gm_version", GM_version,
@"Returns the game's version number,
    - args: []
    - output: string"
)
	
new RunGML_Op("update",
	function(_i, _l=[]) {
		url_open(global.RunGML_homepage);
		return [];
	},
@"Returns the RunGML web address
    - args: []
    - output: string"
)
	
new RunGML_Op("op_count",
	function(_i, _l=[]) {
		return struct_names_count(_i.language);
	},
@"Returns the number of supported operators
    - args: []
    - output: number"
)
	
new RunGML_Op("op_list",
	function(_i, _l=[]) {
		return struct_get_names(_i.language);
	},
@"Returns a list of supported operators
    - args: []
    - output: [string, *]"
)
	
new RunGML_Op("op_names",
	function(_i, _l=[]) {
		var _op_list = struct_get_names(_i.language);
		var _str = "";
		for (var i=0; i<array_length(_op_list); i++) {
			if i > 0 _str += ", ";
			_str += _op_list[i];
		}
		return _str;
	},
@"Returns a string listing names of supported operators
    - args: []
    - output: string"
)
	
new RunGML_Op("help",
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
	},
@"Display documentation for RunGML, or for an operator named by the first argument.
    - args: [(string)]
    - output: string"
)
	
new RunGML_Op ("manual",
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
	},
@"Write full documentation for the RunGML language to a file in the save directory.
    - args: [(filename)]
    - output: []"
)
	
	
new RunGML_Op ("this",
	function(_i, _l) {
		return _i;
	},
@"Return a reference to the current RunGML interpreter
    - args: []
    - output: instance"
)
	
new RunGML_Op("parent",
	function(_i, _l) {
		return _i.parent
	},
@"Return a reference to the RunGML interpreter's parent object.
    - args: []
    - output: instance"
)
	
new RunGML_Op("console",
	function(_i, _l) {
		if !instance_exists(oRunGML_Console) {
			global.RunGML_Console = instance_create_depth(0, 0, 0, oRunGML_Console);
		}
		return global.RunGML_Console
	},
@"Returns a reference to the RunGML console, creating one if it doesn't exist
    - args: []
    - output: instance"
)
	
new RunGML_Op("clear",
	function(_i, _l) {
		if object_get_name(variable_instance_get(_i.parent, "object_index")) == "oRunGML_Console" {
			_i.parent.clear_history();
		}
		return [];
	},
@"If run from a console, clear that console's history
    - args: []
    - output: instance"
)

#endregion Metadata
	
#region Control Flow

new RunGML_Op ("pass",
	function(_i, _l=[]) {
		return [];
	},
@"Do nothing
    - args: [*]
    - output: []"
)
	
new RunGML_Op ("run",
	function(_i, _l) {
		return _i.run(_l);
	},
@"Run arguments as a program.
    - args: [*]
    - output: *"
)
	
new RunGML_Op ("exec",
	function(_i, _l) {
		return _i.run(json_parse(_l[0]));
	},
@"Execute a string as a program.
    - args: [string]
    - output: *",
	[new RunGML_Constraint_ArgCount("eq", 1)]
)
	
new RunGML_Op ("last",
	function(_i, _l) {
		var _n = array_length(_l);
		if _n > 0 return _l[_n - 1];
		return [];
	},
@"Return the value of the last argument
    - args: [*]
    - output: *"
)
	
new RunGML_Op ("out",
	function(_i, _l) {
		return {"out": _l};
	},
@"Wrap argument list in a struct so it can be returned unevaluated.
    - args: [*]
    - output: struct"
)
	
new RunGML_Op ("in",
	function(_i, _l) {
		return struct_get(_l[0], "out");
	},
@"Retrieve the output list from a struct produced by the 'out' operator.
    - args: [struct]
    - output: list"
)
	
new RunGML_Op ("import",
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
	},
@"Import JSON from a file
    - args: [string]
    - output: json"
)
	
new RunGML_Op ("runfile",
	function(_i, _l) {
		return _i.run([
			["run", ["import", _l[0]]]
		])
	},
@"Run a program from a file
    - args: [string]
    - output: *"
)
	
new RunGML_Op ("runprog",
	function(_i, _l) {
		return _i.run([
			["run", ["import", ["string", "RunGML/programs/{0}.txt", _l[0]]]]
		])
	},
@"Run a program from a file in the incdlued RunGML/programs directory
    - args: [string]
    - output: *"
)
	
new RunGML_Op ("example",
	function(_i, _l) {
		return _i.run(["run", ["import", ["string", "RunGML/programs/examples/{0}.txt", _l[0]]]])
	},
@"Run an included example program
    - args: [string]
    - output: *"
)
	
new RunGML_Op ("export",
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
	},
@"Export JSON to a file
    - args: [path, data]
    - output: []"
)
	
new RunGML_Op ("list",
	function(_i, _l=[]) {
		return _l;
	},
@"Return arguments as a list
    - args: []
    - output: []"
)
	
new RunGML_Op ("prog",
	function(_i, _l=[]) {
		for (var _line=0; _line<array_length(_l); _line++) {
			_i.run(_l[_line]);
		}
		return [];
	},
@"Run arguments as programs
    - args: []
    - output: []"
)
	
new RunGML_Op("if",
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
	},
@"Evaluate and act on a conditional
    - args: [conditional, {('true': function), ('false': function)}]
    - output: []"
)
	
new RunGML_Op("switch",
	function(_i, _l) {
		// value, case_dict
		if struct_exists(_l[1], _l[0]){
			_i.run(struct_get(_l[1], _l[0]));	
		}
	},
@"Perform switch/case evaluation
    - args: [value, {'case0': function, 'case1': function}]
    - output: []"
)
	
new RunGML_Op("while",
	function(_i, _l) {
		// condition, func
		while(_i.run(_l[0])) {
			_i.run(struct_get(_l[1], "do"));
		}
	},
@"Exectue a function while a condition is true
    - args: [conditional, {'do': function}]
    - output: []"
)
	
new RunGML_Op("repeat",
	function(_i, _l) {
		// count, func
		for (var i=0; i<_l[0]; i++) {
			_i.run(struct_get(_l[1], "do"));
		}
	},
@"Repeat a function a fixed number of times
    - args: [count, function]
    - output: []"
)

#endregion Control Flow
	
#region Constants

new RunGML_Op ("noone", noone,
@"Return the GameMaker constant noone
    - args: []
    - output: noone"
)
	
new RunGML_Op ("undefined", undefined,
@"Return the GameMaker constant undefined
    - args: []
    - output: undefined"
)
	
new RunGML_Op ("pi", pi,
@"Return the value of pi
    - args: []
    - output: pi"
)

#endregion Constants
	
#region Debugging

new RunGML_Op ("print",
	function(_i, _l) {
		for(var i=0; i<array_length(_l); i++) {
			show_debug_message(_l[i]);
		}
		return [];
	},
@"Print a debug message
    - args: [string]
    - output: []"
)

#endregion Debugging
	
#region Text

new RunGML_Op ("string",
	function(_i, _l) {
		var _s = array_shift(_l);
		return string_ext(_s, _l);
	},
@"Format a string
    - args: [template, (var0), ...]
    - output: [string]"
)
	
new RunGML_Op("draw_text",
	function(_i, _l) {
		// x, y, string
		draw_text(_l[0], _l[1], _l[2]);
	},
@"Draw text
    - args: [x, y, string]
    - output: []"
)

#endregion Types
		
#region Accessors
new RunGML_Op ("v",
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
	},
@"Get and set variables.  Behavior changes based on number of arguments:
0: Returns the interpreter's entire registers struct.
1: Returns the value saved in the named register.
2: Sets the register named by the first argument to the value of the second argument.
    - args: [int] or [string]
    - output: *"
)
	
new RunGML_Op ("r",
	function(_i, _l) {
		if array_length(_l) == 0 return _i.registers;
		if struct_exists(_i.language, _l[0]) {
			for (var i=1; i<array_length(_l); i++) {
				_l[i] = struct_get(_i.registers, _l[i]);
			}
			return _i.run(_l);
		}
		else return undefined;
	},	
@"The register operator.
If no arguments are provided, returns the interpreter's registers struct
If the first argument names an operator, replaces any other integer arguments with the corresponding register values and runs that operator on the resulting list.
For example, the following two programs are functionally equivalent:
['r', 'add', 0, 1]
['add', ['g', 0], ['g', 1]]
They will return the sum of the values in registers 0 and 1.
    - args: [index] or [operator, index0, index1, ...]
    - output: [value] or the rusult of applying the named operator"
)
	
new RunGML_Op("global",
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
	},
@"Create, read, or modify global variables.
Behavior depends on the number of arguments:
0: return an empty struct
1: returns {'struct': arg0}
2: returns get_struct(arg0, arg1)
    - args: []
    - output: []"
)
	
new RunGML_Op("inst",
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
	},
@"Get and set instance variables.
Behavior depends on the number of arguments:
2: returns variable_instance_get(arg0, arg1)
3: does variable_instance_set(arg0, arg1, arg2)
    - args: [instance, index, (value)]
    - output: *"
)
	
new RunGML_Op("struct",
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
	},
@"Create, read, or modify a struct.
Behavior depends on the number of arguments:
0: return an empty struct
1: returns {'struct': arg0}
2: returns get_struct(arg0, arg1)
3: returns set_struct(arg0, arg1, arg2);
    - args: []
    - output: []"
)
	
new RunGML_Op("struct_keys",
	function(_i, _l) {
		// struct, variable
		return struct_get_names(_l[0]);
	},
@"Get a list of the keys in a struct
    - args: [struct]
    - output: [string, ...]"
)

new RunGML_Op("array",
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
	},
@"Create, read, or modify a struct.
Behavior depends on the number of arguments:
0: return an empty array
1: returns [arg0]
2: returns arg0[arg1]
3: sets arg0[arg1] = arg2;
    - args: [(array), (index), (value)]
    - output: [*]"
)
	
new RunGML_Op("len",
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
	},
@"Returns the length of a string, array, or struct.
    - args: [string/array/struct]
    - output: length"
)

#endregion Accessors

#region Math

new RunGML_Op("add",
	function(_i, _l) {
		// a, b
		return _l[0] + _l[1];
	},
@"Add two numbers
    - args: [A, B]
    - output: A + B"
)
	
new RunGML_Op("sub",
	function(_i, _l) {
		// a, b
		return _l[0] - _l[1];	
	},
@"Subtract two numbers
    - args: [A, B]
    - output: A - B",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)
	
new RunGML_Op("mult",
	function(_i, _l) {
		// a, b
		return _l[0] * _l[1];	
	},
@"Multiply two numbers
    - args: [A, B]
    - output: A * B"
)
	
new RunGML_Op("div",
	function(_i, _l) {
		//a, b
		return _l[0] / _l[1];	
	},
@"Divide two numbers
    - args: [A, B]
    - output: A / B"
)
	
new RunGML_Op("pow",
	function(_i, _l) {
		return power(_l[0], _l[1]);
	},
@"Raise one number to the power of another
    - args: [A, B]
    - output: A ^ B"
)
	
new RunGML_Op("clamp",
	function(_i, _l) {
		return clamp(_l[0], _l[1], _l[2]);
	},
@"Clamp a number between a minimum and maximum value
    - args: [number, min, max]
    - output: number"
)
	
new RunGML_Op("approach",
	function(_i, _l) {
		var _val = _l[0] + _l[1];
		_val = clamp(_val, _l[2], _l[3]);
		return _val;
	},
@"Increment a number by some amount while staying within a range
    - args: [number, increment, min, max]
    - output: [number]"
)
	
new RunGML_Op("mod",
	function(_i, _l) {
		return _l[0] mod _l[1];
	},
@"Modulo operator
    - args: [A, B]
    - output: A mod B"
)

#endregion Math
	
#region Objects

new RunGML_Op("object",
	function(_i, _l) {
		var _inst = instance_create_layer(_l[0], _l[1], _l[2], oRunGML_ObjectTemplate);
		_inst.event_dict = _l[3]
		_inst.run_event("create")
		return _inst;
	},
@"Create a new oRunGML_Object instance and return its index
    - args: [x, y, layer_name, event_dictionary]
    - output: oRunGML_Object instance"
)
	
new RunGML_Op("inst_create_layer",
	function(_i, _l) {
		// x, y, layer, object_index
		return instance_create_layer(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
	},
@"Create a new object on the specified layer
    - args: [x, y, layer, object_index]
    - output: [instance_id]"
)
	
new RunGML_Op("inst_create_depth",
	function(_i, _l) {
		// x, y, depth, object_index
		return instance_create_depth(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
	},
@"Create a new object at the specified depth
    - args: [x, y, depth, object_index]
    - output: [instance_id]"
)
	
new RunGML_Op("destroy",
	function(_i, _l) {
		instance_destroy(_l[0]);
	},
@"Destroy an instance
    - args: [instance_id]
    - output: []"
)

#endregion Objects
	
#region Logic

new RunGML_Op("and",
	function(_i, _l) {
		return _l[0] and _l[1];	
	},
@"Returns true iff both arguments are true
    - args: [A, B]
    - output: A and B"
)
	
new RunGML_Op("or",
	function(_i, _l) {
		return _l[0] or _l[1];	
	},
@"Returns true if either argument is true
    - args: [A, B]
    - output: [(A or B)]"
)
	
new RunGML_Op("not",
	function(_i, _l) {
		return not _l[0];
	},
@"Returns the inverse of the argument's boolean value
    - args: [A]
    - output: [!A]"
)
	
new RunGML_Op("eq",
	function(_i, _l) {
		return _l[0] == _l[1];	
	},
@"Returns true iff the two arguments are equal
    - args: [A, B]
    - output: [(A == B)]"
)
	
new RunGML_Op("lt",
	function(_i, _l) {
		return _l[0] < _l[1];	
	},
@"Returns true iff the first argument is less than the second
    - args: [A, B]
    - output: [(A < B)]"
)
	
new RunGML_Op("gt",
	function(_i, _l) {
		return _l[0] > _l[1];	
	},
@"Returns true iff the first argument is greater than the second
    - args: [A, B]
    - output: [(A > B)]"
)
	
new RunGML_Op("leq",
	function(_i, _l) {
		return _l[0] <= _l[1];	
	},
@"Returns true iff the first argument is less than or equal to the second
    - args: [A, B]
    - output: [(A <= B)]"
)
	
new RunGML_Op("geq",
	function(_i, _l) {
		return _l[0] >= _l[1];	
	},
@"Returns true iff the first argument is greater than or equal to the second
    - args: [A, B]
    - output: [(A >= B)]"
)
	
new RunGML_Op("neq",
	function(_i, _l) {
		return _l[0] != _l[1];	
	},
@"Returns true iff the two arguments are not equal
    - args: [A, B]
    - output: [(A != B)]"
)

#endregion Logic
	
#region Rooms

new RunGML_Op("room_w",
	function(_i, _l=[]) {
		//
		return room_width;	
	},
@"Returns the width of the current room.
    - args: []
    - output: [width]"
)
	
new RunGML_Op("room_h",
	function(_i, _l=[]) {
		//
		return room_height;
	},
@"Returns the height of the current room.
    - args: []
    - output: [height]"
)

#endregion Rooms
	
#region Displays

new RunGML_Op("display_w",
	function(_i, _l=[]) {
		//
		return display_get_width();	
	},
@"Returns the width of the display.
    - args: []
    - output: [width]"
)
	
new RunGML_Op("display_h",
	function(_i, _l=[]) {
		//
		return display_get_height;
	},
@"Returns the height of the display.
    - args: []
    - output: [height]"
)

#endregion Displays
	
#region Drawing

new RunGML_Op("draw_sprite",
	function(_i, _l) {
		// sprite, frame, x, y
		draw_sprite(_l[0], _l[1], _l[2], _l[3]);
	},
@"Draw a sprite
    - args: [sprite_index, frame, x, y]
    - output: []"
)
	
new RunGML_Op("draw_sprite_general",
	function(_i, _l) {
		// sprite, frame, left, top, width, height, x, y, xscale, yscale, rot, c1, c2, c3, c4, alpha
		draw_sprite_general(_l[0], _l[1], _l[2], _l[3], _l[4], _l[5], _l[6], _l[7], _l[8], _l[9], _l[10], _l[11], _l[12], _l[13], _l[14], _l[15])	
	},
@"Draw a sprite using additional parameters
    - args: [sprite_index, frame, left, top, width, height, x, y, xscale, yscale, rot, c1, c2, c3, c4, alpha]
    - output: []"
)

new RunGML_Op("draw_color",
	function(_i, _l) {
		if array_length(_l) < 1 return draw_get_color();
		draw_set_color(_l[0]);
		return [];
	},
@"Get or set the draw color.
    - args: [(color)]
    - output: (color)"
)
	
new RunGML_Op("draw_alpha",
	function(_i, _l) {
		if array_length(_l) < 1 return draw_get_alpha();
		draw_set_alpha(_l[0]);
		return [];
	},
@"Get or set the draw alpha.
    - args: [(alpha)]
    - output: (alpha)"
)
	
new RunGML_Op("draw_halign",
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
	},
@"Get or set the horizontal draw alignment
    - args: [(value)]
    - output: (value)"
)
	
new RunGML_Op("draw_valign",
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
	},
@"Get or set the vertical draw alignment
    - args: [(value)]
    - output: (value)"
)
	
new RunGML_Op("rgb",
	function(_i, _l) {
		return make_color_rgb(_l[0], _l[1], _l[2]);	
	},
@"Create an RGB color
    - args: [red, green, blue]
    - output: color"
)
	
new RunGML_Op("hsv",
	function(_i, _l) {
		return make_color_hsv(_l[0], _l[1], _l[2]);	
	}, 
@"Create an HSV color
    - args: [hue, saturation, value]
    - output: color"
)
	
#endregion Drawing
	
new RunGML_Op("fps",
	function(_i, _l) {
		return fps;
	}, 
@"Get the current fps (capped at the room speed)
    - args: []
    - output: fps"
)
	
new RunGML_Op("fps_real",
	function(_i, _l) {
		return fps_real;
	}, 
@"Get the current fps (not capped at the room speed)
    - args: []
    - output: fps_real"
)
	
new RunGML_Op("game_speed",
	function(_i, _l) {
		if array_length(_l) > 0 {
			game_set_speed(_l[0], gamespeed_fps);
			return [];
		} else return game_get_speed(gamespeed_fps);
	}, 
@"Get or set the game speed in terms of fps
    - args: [(game_speed)]
    - output: (game_speed)"
)

new RunGML_Op("nth",
	function(_i, _l) {
		switch(_l[0] mod 10){
			case 1:
				return "st"
			case 2:
				return "nd"
			default:
				return "rd"
		}
	},
@"Get the ordinal suffix for a given number ()
    - args: [number]
    - output: 'st', 'nd', or 'rd'"
)
	
new RunGML_Op("quit",
	function(_i, _l) {
		game_end();
		return [];
	}, 
@"Quit the game
    - args: []
    - output: []"
)
	


#region Misc
new RunGML_Op("nggyu",
	function(_i, _l) {
		url_open("https://sdlwdr.github.io/rickroll/rickroll.mp4");
		return [];
	},
@"Got 'em!
    - args: []
    - output: []"
)

new RunGML_Op ("test_constant", 23);
#endregion Misc


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
		
		var _op_name = array_shift(_l);
		var _out = _op_name;
		if struct_exists(language, _op_name) {
			var _op = struct_get(language, _op_name);
			if debug show_debug_message(@"RunGML_I:{0}[{1}].exec({2}({3}))", name, recursion, _op_name, _l);
			var _out = _op.exec(self, _l);
		}
		recursion -= 1;
		return _out;
	}
}

RunGML_Config();