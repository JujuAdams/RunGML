#macro RunGML_version "2025_03_23_00"
#macro RunGML_homepage "https://github.com/sdelaughter/RunGML"

function RunGML_Interpreter(_name="RunGML_I") constructor {
	name = _name;
	language = global.RunGML_Ops;
	aliases = global.RunGML_Aliases;
	debug = global.RunGML_I_debug;
	throw_errors = global.RunGML_throwErrors;
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
		while struct_exists(aliases, _op_name) {
			_op_name = struct_get(aliases, _op_name);	
		}
		if struct_exists(language, _op_name) {
			var _op = struct_get(language, _op_name);
			if debug show_debug_message(@"RunGML_I:{0}[{1}].exec({2}({3}))", name, recursion, _op_name, _l);
			_out = _op.exec(self, _l);
		}
		recursion -= 1;
		return _out;
	}
}

function RunGML_Error(_msg="") constructor {
	prefix = string("### {0}_START ###\n", instanceof(self));
	suffix = string("\n### {0}_END ###", instanceof(self));
	msg = string(_msg);
	warn = function(_i=noone) {
		var _formatted = prefix + msg + suffix
		if _i != noone {
			if _i.throw_errors throw(_formatted);
			return;
		}
		show_debug_message(_formatted);
	}
}

function RunGML_Constraint(_check=noone, _doc=noone) constructor {
	if _check == noone {
		_check = function(_l) {return true}
	}
	check = _check;

	if _doc == noone {
		doc = function() {return string("true")}
	}
	doc = _doc;
}

function RunGML_Constraint_ArgCount(_op="eq", _count=noone) : RunGML_Constraint() constructor {
	count = _count
	op = _op
	err_msg = @"ArgCount constraint violated
    - args: {0}
    - test: {1}
    - got: {2}"
	doc = function() {return string("count(args) {0} {1}", op, count)}
	check = function(_l) {
		var _valid;
		var _len = array_length(_l);
		switch(op) {
			case "eq":
				_valid = _len == count;
				break;
			case "nq":
				_valid = _len != count;
				break;
			case "gt":
				_valid = _len > count;
				break;
			case "geq":
				_valid = _len >= count;
				break;
			case "lt":
				_valid = _len < count;
				break;
			case "leq":
				_valid = _len <= count;
				break;
			case "in":
				_valid = array_contains(count, _len);
				break;
		}
		if !_valid return new RunGML_Error(string(err_msg, _l, doc(), _len))
		return _valid;
	}
}

function RunGML_Constraint_ArgType(_index="all", _types=noone, _required=true): RunGML_Constraint() constructor {
	index = _index;
	types = _types;
	required = _required
	if types == "numeric" types = ["number", "int32", "int64"];
	if typeof(types) != "array" types = [types];
	doc = function() {
		var _docstring = string("typeof(args[{0}]) in {1}", index, types)
		if required _docstring += " (required)"
		else _docstring += " (optional)"
		return _docstring
	}
	err_msg = @"ArgType constraint violated
    - args: {0}
    - test: {1}
    - got: {2}"
	
	check = function(_l) {
		if types == noone return true;
		var _val, _type;
		if index == "all" {
			for (var i=0; i<array_length(_l); i++) {
				_val = _l[i];
				_type = typeof(_val);
				if not array_contains(types, _type) {
					return new RunGML_Error(string(err_msg, _l, doc(), _type))
				}
			}
		} else {
			if index >= array_length(_l) {
				if required {
					_type = undefined;
				} else return true;
			} else {
				_val = _l[index];
				_type = typeof(_val)
			}
			
			if not array_contains(types, _type){
				return new RunGML_Error(string(err_msg, _l, doc(), _type));
			}
		}
		return true;
	}
}

function RunGML_Op(_name, _f, _desc="", _constraints=[]) constructor {
	if struct_exists(global.RunGML_Ops, _name) and not global.RunGML_Config_overwrite return;

	name = _name;
	aliases = [];
	f = _f;
	desc = _desc;
	constraints = _constraints;
	help = function() {
		var _docstring = string(@"- {0}", name);
		if array_length(aliases) > 0 _docstring += string("\n    - aliases: {0}", aliases)
		_docstring += string("\n    - desc: {0}", desc);
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
		if valid(_i, _l) {
			if typeof(f) == "method" {
				try {
					_out = script_execute(f, _i, _l);
				} catch(_e) {
					new RunGML_Error(string("Operator '{0}' failed to execute list: {1}\nTry: ['help', '{0}']", name, _l)).warn(_i);
					return undefined;
				}
			}
			else _out = f;
		}
		return _out;
	}
	
	valid = function(_i, _l) {
		var _constraint, _err;
		for(var i=0; i<array_length(constraints); i++) {
			_constraint = constraints[i];
			_err = constraints[i].check(_l)
			if is_instanceof(_err, RunGML_Error) {
				_err.msg += string("\n    - operator: {0}", name);
				_err.warn(_i);
				return false;
			}
		}
		return true;
	}

	struct_set(global.RunGML_Ops, name, self);
}

function RunGML_alias(_nickname, _name, _aliases=global.RunGML_Aliases, _ops=global.RunGML_Ops) {
	if struct_exists(_aliases, _nickname) {
		new RunGML_Error(string("Cannot redefine alias: {0} -> {1}", _nickname, struct_get(_aliases, _nickname))).warn();
		return -1;
	}
	if struct_exists(_ops, _nickname) {
		new RunGML_Error(string("Cannot create alias with defined operator as nickname: {0}", _nickname, struct_get(_aliases, _nickname))).warn();
		return -1;
	}
	if not struct_exists(_ops, _name) {
		new RunGML_Error(string("Cannot create alias for non-existent operation: {0}", _name)).warn();
		return -1;
	}
	struct_set(_aliases, _nickname, _name);
	array_push(struct_get(struct_get(_ops, _name), "aliases"), _nickname);
}

function RunGML_clone(_l) {
// Deep copy a nested list.  Enables program reuse
	return json_parse(json_stringify(_l));	
}

/* Operator Definitions
Additional operators should be defined in scrRunGML_Config
Make a backup of that file before updating RunGML
Then you can restore your custom settings and operators after updating
*/

global.RunGML_Ops = {}
global.RunGML_Aliases = {}

#region Constants

new RunGML_Op("version", RunGML_version,
@"Returns the RunGML version number
    - args: []
    - output: string",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op("gm_version", GM_version,
@"Returns the game's version number,
    - args: []
    - output: string",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)

new RunGML_Op ("true", true,
@"Return the GameMaker constant true
    - args: []
    - output: true",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)

new RunGML_Op ("false", false,
@"Return the GameMaker constant false
    - args: []
    - output: false",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)

new RunGML_Op ("noone", noone,
@"Return the GameMaker constant noone
    - args: []
    - output: noone",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op ("undefined", undefined,
@"Return the GameMaker constant undefined
    - args: []
    - output: undefined",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op ("pi", pi,
@"Return the value of the mathematical constant e
    - args: []
    - output: pi",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)

new RunGML_Op ("e", exp(1),
@"Return the value of the mathematical constant e
    - args: []
    - output: e",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)

new RunGML_Op ("phi", (1+sqrt(5))/2.0,
@"Return the value of the mathematical constant phi
    - args: []
    - output: phi",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)

#endregion Constants

#region Metadata

new RunGML_Op("update",
	function(_i, _l=[]) {
		url_open(RunGML_homepage);
		return [];
	},
@"Returns the RunGML web address
    - args: []
    - output: string",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op("op_count",
	function(_i, _l=[]) {
		return struct_names_count(_i.language);
	},
@"Returns the number of supported operators
    - args: []
    - output: number",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op("op_list",
	function(_i, _l=[]) {
		var _op_list = struct_get_names(_i.language);
		array_sort(_op_list, true);
		return _op_list;
	},
@"Returns a list of supported operators
    - args: []
    - output: [string, *]",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op("op_names",
	function(_i, _l=[]) {
		var _op_list = struct_get_names(_i.language);
		array_sort(_op_list, true);
		var _str = "";
		for (var i=0; i<array_length(_op_list); i++) {
			if i > 0 _str += ", ";
			_str += _op_list[i];
		}
		return _str;
	},
@"Returns a string listing names of supported operators
    - args: []
    - output: string",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op("help",
	function(_i, _l=[]) {
		if array_length(_l) > 0 {
			var _op_name = _l[0];
			if struct_exists(_i.aliases, _op_name) {
				_op_name = struct_get(_i.aliases, _op_name);
			}
			var _op = struct_get(_i.language, _op_name)
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

Run ["update"] to visit the homepage to read documentation, check for updates, report bugs, or request features.

Run ["op_names"] to list all {2} supported operators.

Run ["help", "some_operator_name"] to get documentation on a specific operator.

Run ["manual"] to generate full documentation for all operators.
', 
					["version"],
					["global", "RunGML_homepage"],
					["op_count"],
				]
			)
		}	
	},
@"Display documentation for RunGML, or for an operator named by the first argument.
    - args: [(string)]
    - output: string", 
	[
		new RunGML_Constraint_ArgCount("leq", 1),
		new RunGML_Constraint_ArgType(0, "string", false)
	]
)
	
new RunGML_Op ("manual",
	function(_i, _l) {
		var _filename = "RunGML/manual.md";
		if array_length(_l) > 0 _filename = _l[0];
		if file_exists(_filename) file_delete(_filename);
		var _f = file_text_open_append(_filename)
		var _ops = variable_struct_get_names(_i.language);
		array_sort(_ops, true);
		var _op, _op_name;
		file_text_write_string(_f, _i.run(["help"]));
		file_text_write_string(_f, "\n\n## Operators\n");
		for (var i=0; i<array_length(_ops); i++) {
			_op_name = _ops[i];
			_op = struct_get(_i.language, _op_name)
			if _op.name != _op_name continue; // Don't re-document aliases
			file_text_write_string(_f, "\n"+_op.help()+"\n")
		}
		file_text_close(_f);
		url_open(_filename)
		return [];
	},
@"Write full documentation for the RunGML language to a file in the save directory.
    - args: [(filename)]
    - output: []",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
	
new RunGML_Op ("this",
	function(_i, _l) {
		return _i;
	},
@"Return a reference to the current RunGML interpreter
    - args: []
    - output: instance",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)
	
new RunGML_Op("parent",
	function(_i, _l) {
		switch(array_length(_l)) {
			case 0:
				return _i.parent;
				break;
			case 1:
				return struct_get(_i.parent, _l[0]);
				break;
			case 2:
			default:
				struct_set(_i.parent, _l[0], _l[1]);
				break;
		}
		
	},
@"Return a reference to the RunGML interpreter's parent object.
    - args: []
    - output: instance",
	[new RunGML_Constraint_ArgCount("leq", 2)]
)
	
new RunGML_Op("console",
	function(_i, _l) {
		if !instance_exists(oRunGML_Console) {
			global.RunGML_Console = instance_create_depth(0, 0, 0, oRunGML_Console);
		}
		return global.RunGML_Console
	},
@"Return a reference to the RunGML console, creating one if it doesn't exist
    - args: []
    - output: instance",
	[new RunGML_Constraint_ArgCount("eq", 0)]
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
    - output: instance",
	[new RunGML_Constraint_ArgCount("eq", 0)]
)

new RunGML_Op ("alias",
	function(_i, _l=[]) {
		switch(array_length(_l)) {
			case 0:
				return _i.aliases;
				break;
			case 1:
				var _out = [];
				if struct_exists(_i.aliases, _l[0]) {
					var _name =  struct_get(_i.aliases, _l[0]);
					_out = array_concat([_name], struct_get(struct_get(_i.language, _name), "aliases"));
				} else if struct_exists(_i.language, _l[0]) {
					_out = array_concat([_l[0]], struct_get(struct_get(_i.language, _l[0]), "aliases"));
				}
				return _out;
				break;
			case 2:
			default:
				return RunGML_alias(_l[0], _l[1]);
				break;
		}		
	},
@"Create an operator alias. Behavior depends on the number of arguments:
        - 0: Return the interpreter's entire alias struct
        - 1: If the argument names an operator or alias, return a list of all synonyms starting with the real name.
        - 2: Creates a new alias with nickname arg0 for operator arg1.  arg0 cannot be in use, arg1 must be defined.
    - args: [(nickname), (name)]
    - output: struct or list",
	[
		new RunGML_Constraint_ArgCount("leq", 2),
		new RunGML_Constraint_ArgType(0, "string", false),
		new RunGML_Constraint_ArgType(1, "string", false)
	]
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
	[
		new RunGML_Constraint_ArgCount("eq", 1),
		new RunGML_Constraint_ArgType(0, "string")
	]
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
    - output: list",
	[new RunGML_Constraint_ArgType(0, "struct")]
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
    - args: [filepath]
    - output: json",
	[new RunGML_Constraint_ArgType(0, "string")]
)
	
new RunGML_Op ("runfile",
	function(_i, _l) {
		return _i.run([
			["run", ["import", _l[0]]]
		])
	},
@"Run a program from a file
    - args: [filepath]
    - output: *",
	[new RunGML_Constraint_ArgType(0, "string")]
)
	
new RunGML_Op ("runprog",
	function(_i, _l) {
		return _i.run([
			["run", ["import", ["string", "RunGML/programs/{0}.txt", _l[0]]]]
		])
	},
@"Run a program from a file in the incdlued RunGML/programs directory
    - args: [program_name]
    - output: *",
	[new RunGML_Constraint_ArgType(0, "string")]
)
	
new RunGML_Op ("example",
	function(_i, _l) {
		return _i.run(["run", ["import", ["string", "RunGML/programs/examples/{0}.txt", _l[0]]]])
	},
@"Run an included example program
    - args: [example_program_name]
    - output: *",
	[new RunGML_Constraint_ArgType(0, "string")]
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
    - args: [path, data, (pretty=true)]
    - output: []",
	[
		new RunGML_Constraint_ArgType(0, "string"),
		new RunGML_Constraint_ArgType(1, ["array", "struct"]),
		new RunGML_Constraint_ArgType(2, "bool", false),
	]
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
    - output: []",
	[new RunGML_Constraint_ArgType(0, "array")]
)
	
new RunGML_Op("if",
	function(_i, _l) {
		if(_l[0]) {
			if struct_exists(_l[1], "true") {
				_i.run(struct_get(_l[1], "true"));
			}
		} else if struct_exists(_l[1], "false") {
			_i.run(struct_get(_l[1], "false"));
		}
	},
@"Evaluate and act on a conditional
    - args: [conditional {'true': program, 'false': program}]
    - output: []",
	[
		new RunGML_Constraint_ArgType(0, "bool"),
		new RunGML_Constraint_ArgType(1, "struct"),
	]
)
	
new RunGML_Op("switch",
	function(_i, _l) {
		// value, case_dict
		if struct_exists(_l[1], _l[0]){
			_i.run(struct_get(_l[1], _l[0]));	
		} else if struct_exists(_l[1], "default") {
			_i.run(struct_get(_l[1], "default"));
		}
	},
@"Perform switch/case evaluation
    - args: [value, {'case0': program, 'case1': program, 'default': program}]
    - output: []",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType(1, "struct")
	]
)
	
new RunGML_Op("while",
	function(_i, _l) {
		// condition, func
		var _check = struct_get(_l[0], "check")
		var _f = struct_get(_l[0], "do")
		while(true) {
			if _i.run(RunGML_clone(_check)) {
				_i.run(RunGML_clone(_f));
			} else break;
		}
	},
@"Exectue a function while a condition is true
    - args: [{'check': program, 'do': program}]
    - output: []",
	[
		new RunGML_Constraint_ArgType(0, "struct")
	]
)
	
new RunGML_Op("repeat",
	function(_i, _l) {
		// count, func
		for (var i=0; i<_l[0]; i++) {
			_i.run(struct_get(_l[1], "do"));
		}
	},
@"Repeat a function a fixed number of times
    - args: [count, program]
    - output: []",
	[
		new RunGML_Constraint_ArgType(0, "numeric"),
		new RunGML_Constraint_ArgType(1, "list")
	]
)

#endregion Control Flow
	

	
#region Debugging

new RunGML_Op ("print",
	function(_i, _l) {
		for(var i=0; i<array_length(_l); i++) {
			show_debug_message(string(_l[i]));
		}
		return [];
	},
@"Print a debug message
    - args: [stringable, (...)]
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
    - output: [string]",
	[new RunGML_Constraint_ArgType(0, "string")]
)

new RunGML_Op ("cat",
	function(_i, _l) {
		var _out = "";
		for (var i=0; i<array_length(_l); i++) {
			_out += string(_l[i]);	
		}
		return _out;
	},
@"Concatenate arguments into a single string
    - args: [value, (...)]
    - output: [string]",
)
	
new RunGML_Op("draw_text",
	function(_i, _l) {
		// x, y, string
		draw_text(_l[0], _l[1], _l[2]);
	},
@"Draw text
    - args: [x, y, string]
    - output: []",
	[
		new RunGML_Constraint_ArgCount("eq", 3),
		new RunGML_Constraint_ArgType(0, "numeric"),
		new RunGML_Constraint_ArgType(1, "numeric"),
		new RunGML_Constraint_ArgType(2, "string")
	]
)

#endregion Types
		
#region Accessors
new RunGML_Op ("var",
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
        - 0: Returns the interpreter's entire registers struct.
        - 1: Returns the value saved in the named register.
        - 2: Sets the register named by the first argument to the value of the second argument.
    - args: [int] or [string]
    - output: *"
)
	
new RunGML_Op ("reference",
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
@"Operate on referenced values.  Behavior depends on the number of arguments:
        - 0: Return the interpreter's registers struct (same as ['v'])
        - 1+: If the first argument names an operator:
            - Substitute any other arguments that name defined reigsters with their values.
            - Run the first-argument operator on the resulting list of substituted arguments.
            - For example, the following two programs are functionally equivalent:
                - ['r', 'add', 'foo', 'bar']
                - ['add', ['v', 'foo'], ['v', 'bar']]
            - They will return the sum of the values in registers foo' and 'bar'.
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
@"Create, read, or modify global variables. Behavior depends on the number of arguments:
        - 0: return an empty struct
        - 1: returns {'struct': arg0}
        - 2: returns get_struct(arg0, arg1)
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
@"Get and set instance variables. Behavior depends on the number of arguments:
        - 2: returns variable_instance_get(arg0, arg1)
        - 3: does variable_instance_set(arg0, arg1, arg2)
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
        - 0: return an empty struct
        - 1: returns {'struct': arg0}
        - 2: returns get_struct(arg0, arg1)
        - 3: returns set_struct(arg0, arg1, arg2);
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
@"Create, read, or modify a struct. Behavior depends on the number of arguments:
        - 0: return an empty array
        - 1: returns [arg0]
        - 2: returns arg0[arg1]
        - 3: sets arg0[arg1] = arg2;
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
@"Add two or more numbers (use 'cat' or 'string' to combine strings)
    - args: [A, B]
    - output: A + B (+ ...)",
	[
		new RunGML_Constraint_ArgCount("geq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
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
    - output: A * B",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)
	
new RunGML_Op("div",
	function(_i, _l) {
		//a, b
		return _l[0] / _l[1];	
	},
@"Divide two numbers
    - args: [A, B]
    - output: A / B",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)
	
new RunGML_Op("pow",
	function(_i, _l) {
		return power(_l[0], _l[1]);
	},
@"Raise one number to the power of another
    - args: [A, B]
    - output: A ^ B",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

new RunGML_Op("exp",
	function(_i, _l) {
		return exp(_l[0]);
	},
@"Raise e to some power
    - args: [number]
    - output: e ^ number",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)

new RunGML_Op("log",
	function(_i, _l) {
		if array_length(_l) == 1 {
			return log10(_l[0]);
		} else return logn(_l[1], _l[0]);
	},
@"Compute a logarithm.  Behavior depends on the number of arguments:
        - 0: Return the log of the argument in base 10
		- 1: Return the log of arg0 in the base of arg1
    - args: [number, (base=10)]
    - output: log_base(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric"),
		new RunGML_Constraint_ArgType(1, "numeric", false)
	]
)

new RunGML_Op("mod",
	function(_i, _l) {
		return _l[0] mod _l[1];
	},
@"Modulo operator
    - args: [A, B]
    - output: A mod B",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

new RunGML_Op("min",
	function(_i, _l) {
		return min(_l[0], _l[1]);
	},
@"Return the smaller of two numbers
    - args: [A, B]
    - output: min(A, B)",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

new RunGML_Op("max",
	function(_i, _l) {
		return max(_l[0], _l[1]);
	},
@"Return the larger of two numbers
    - args: [A, B]
    - output: max(A, B)",
	[
		new RunGML_Constraint_ArgCount("eq", 2),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

new RunGML_Op("round",
	function(_i, _l) {
		return round(_l[0]);
	},
@"Rounds a number
    - args: [number]
    - output: round(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)

new RunGML_Op("floor",
	function(_i, _l) {
		return floor(_l[0]);
	},
@"Rounds a number down
    - args: [number]
    - output: floor(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)

new RunGML_Op("ceil",
	function(_i, _l) {
		return ceil(_l[0]);
	},
@"Rounds a number up
    - args: [number]
    - output: ceil(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)

new RunGML_Op("frac",
	function(_i, _l) {
		return frac(_l[0]);
	},
@"Returns the fractional portion of a number
    - args: [number]
    - output: frac(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)

new RunGML_Op("sign",
	function(_i, _l) {
		return sign(_l[0]);
	},
@"Returns the sign of a number (1 if positive, -1 if negative)
    - args: [number]
    - output: sign(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)

new RunGML_Op("abs",
	function(_i, _l) {
		return abs(_l[0]);
	},
@"Returns the absolute value of a number
    - args: [number]
    - output: abs(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)

new RunGML_Op("abs",
	function(_i, _l) {
		return abs(_l[0]);
	},
@"Returns the absolute value of a number
    - args: [number]
    - output: abs(number)",
	[
		new RunGML_Constraint_ArgType(0, "numeric")
	]
)
	
new RunGML_Op("clamp",
	function(_i, _l) {
		return clamp(_l[0], _l[1], _l[2]);
	},
@"Clamp a number between a minimum and maximum value
    - args: [number, min, max]
    - output: number",
	[
		new RunGML_Constraint_ArgCount("eq", 3),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

new RunGML_Op("lerp",
	function(_i, _l) {
		return lerp(_l[0], _l[1], _l[2]);
	},
@"Lerp between two numbers by a given amount
    - args: [min, max, fraction]
    - output: number",
	[
		new RunGML_Constraint_ArgCount("eq", 3),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

new RunGML_Op("map_range",
	function(_i, _l) {
		return (_l[0] - _l[1]) * (_l[4] - _l[3]) / (_l[2] - _l[1]) + _l[3];
	},
@"Map a value proportionally from one range to another
    - args: [number, in_min, in_max, out_min, out_max]
    - output: number",
	[
		new RunGML_Constraint_ArgCount("eq", 5),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

function map_range(_val, _in_min, _in_max, _out_min, _out_max) {
  
}
	
new RunGML_Op("approach",
	function(_i, _l) {
		var _val = _l[0] + _l[1];
		_val = clamp(_val, _l[2], _l[3]);
		return _val;
	},
@"Increment a number by some amount while staying within a range
    - args: [number, increment, min, max]
    - output: [number]",
	[
		new RunGML_Constraint_ArgCount("eq", 4),
		new RunGML_Constraint_ArgType("all", "numeric")
	]
)

#endregion Math
	
#region Objects

new RunGML_Op("object",
	function(_i, _l) {
		var _inst;
		if typeof(_l[2]) == "string" {
			_inst = instance_create_layer(_l[0], _l[1], _l[2], oRunGML_ObjectTemplate);
		} else {
			_inst = instance_create_depth(_l[0], _l[1], _l[2], oRunGML_ObjectTemplate);
		}
		_inst.event_dict = _l[3]
		_inst.run_event("create")
		return _inst;
	},
@"Create a new oRunGML_Object instance and return its index
    - args: [x, y, depth/layer_name, event_dictionary]
    - output: oRunGML_Object instance",
	[
		new RunGML_Constraint_ArgCount("eq", 4),
		new RunGML_Constraint_ArgType(0, "numeric"),
		new RunGML_Constraint_ArgType(1, "numeric"),
		new RunGML_Constraint_ArgType(2, ["string", "number", "int32", "int64"]),
		new RunGML_Constraint_ArgType(3, "struct")
	]
)
	
new RunGML_Op("create",
	function(_i, _l) {
		// x, y, layer, object_index
		if typeof(_l[2]) == "string" {
			return instance_create_layer(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
		} else {
			return instance_create_depth(_l[0], _l[1], _l[2], asset_get_index(_l[3]));
		}
	},
@"Create a new object instance
    - args: [x, y, depth/layer_name, object_name]
    - output: [instance_id]"
	,
	[
		new RunGML_Constraint_ArgCount("eq", 4),
		new RunGML_Constraint_ArgType(0, "numeric"),
		new RunGML_Constraint_ArgType(1, "numeric"),
		new RunGML_Constraint_ArgType(2, ["string", "number", "int32", "int64"]),
		new RunGML_Constraint_ArgType(3, "string")
	]
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

new RunGML_Op("fullscreen",
	function(_i, _l=[]) {
		//
		if array_length(_l) > 0 window_set_fullscreen(_l[0])
		else window_set_fullscreen(not window_get_fullscreen());
		return [];
	},
@"Toggle fullscreen mode.  Set status with a single boolean argument, or swap status with no arguments.
    - args: [(bool)]
    - output: []"
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

#region Misc
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

new RunGML_Op("rickroll",
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

#region Aliases
RunGML_alias("g", "global");
RunGML_alias("r", "reference");
RunGML_alias("v", "var");
RunGML_alias("q", "quit");
RunGML_alias("multiply", "mult");
RunGML_alias("subtract", "sub");
RunGML_alias("divide", "div");
RunGML_alias("True", "true");
RunGML_alias("False", "false");
#endregion Aliases

RunGML_ConfigOps();