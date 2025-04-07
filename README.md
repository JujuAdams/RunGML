# RunGML
A runtime scripting language for GameMaker.

## Overview

RunGML is a runtime scripting language embedded in GameMaker Language.
It has a Lisp-like structure of nested lists, with a JSON-compatible syntax.
It is a replacement for GameMaker's obsoleted `execute_string` function, and then some.

You can use it to:
- Debug your code
- Provide modding support
- Add secret content from encrypted files
- Make arbitrary changes to your game while it runs

In addition to the RunGML language definition and interpreter, this library also includes:
- An [interactive console](#console)
- A [template object](#objects) with events pre-defined to execute RunGML programs
- A test room, test object, and example programs to demonstrate basic functionality
    - See [bounce_annotated.md](bounce_annotated.md) for a line-by-line explanation of the [bounce](src/datafiles/RunGML/programs/examples/bounce.json) example program.
- Thorough documentation that can be accessed using `"help"` or `"manual`.  The latter generates markdown-formatted documentation for all operators, a copy of which is included here as [manual.md](manual.md).

## Running Programs

First create an instance of the RunGML interpreter:

`RunGMLI = new RunGML_Interpreter()`

Then you can pass your program as a list:

`RunGMLI.run(["print", "Hello, world!"])`

You can also execute programs that are stored in JSON files:

`RunGMLI.runfile(["filepath"])`

Programs stored in `[included files directory]/RunGML/programs/` can be quickly run by name (excluding the `.json` extension, it will be added automatically):

`RunGMLI.runfile(["filename"])`

You can also write and run code from within your game using the [console](#console).

## Syntax

Every program is a list.

The simplest program is: `[]`

The simplest operator (`"pass"`) is: `function(arg_list){return []}`

In addition to lists there are also strings, numbers, and structs.

### List Evaluation Procedure

The RunGML Interpreter evaluates a list as follows:
- An empty list returns nothing.
- Any list elements that are lists will be evaluated first (recursively).
- If the first element is (or evaluates to) a string naming an operator, that operator will be applied to any remaining elements and the result will be returned.
- Otherwise, the first element itself will be returned.

In code:

```
run = function(_l) {
    if array_length(_l) < 1 return;
    for (var i=0; i<array_length(_l); i++) {
        if typeof(_l[i]) == "array" {
            _l[i] = run(_l[i]);
        }
    }
    var _op_name = array_shift(_l);
    var _out = _op_name;
    if struct_exists(language, _op_name) {
        var _op = struct_get(language, _op_name);
        var _out = _op.exec(self, _l);
    }
    return _out;
}
```

### Single-Line Programs

The basic syntax is:

`["operator_name", argument_0, argument_1, ...]`

For example, you can print a debug message with:

`["print", "Hello, world!"]`

Lists can be nested to create more complicated programs.  The following are all equivalent:

`["print", 5]`

`["print", ["add", 2, 3]]`

`["print", [["string", "{0}{1}{2}", "a", "d", "d"], 2, 3]]`


### Multi-Line Programs

In a sense every RunGML program is a single-line since it must be contained in a single outer list, but you can structure multi-line programs in several ways.

Common approaches are to start with the `"pass"`, `"last"`, or `"list"` operators.

`"pass"` evaluates all of its arguments and returns `[]`
`"last"` evaluates all of its arguments are returns the last one's value
`"list"` evaluates all of its arguments and 

Use pass
```
["pass",
  ["print", "Hello, world!"],
  ["add", 2, 3]  
]
```

### Variables

Each instance of the RunGML interpreter maintains a struct of named registers that can be used to define variables.
Setting and reading register values is done with the "v" (variable) operator
  - Passing a single argument will get the value stored in the register that argument names.
  - Passing two values will set the register named by the first argument to the value of the second argument.
  - Calling "v" with no arguments will return the register struct itself

Integers can also be used to name variables, but they will be cast to string representations before use.  For example, the following program will return the number 2:
```
["last",
  ["v", 0, 1]
  ["v", "0", 2]
  ["v", 0]
]
```

### Register Operations

The "r" (register) operator provides a convenient way to pass named variables to other operations.  Its first argument will be interpreted as a new operator name with any additional arguments passed to it, but any of those additional arguments that name a register with a defined value will pass that value to the new operator instead.

For example, the following programs are equivalent (they will all return the value 5):

```
["add", 2, 3]
```

```
["last",
  ["v", "foo", 2],
  ["v", "bar", 3],
  ["add", ["v", "foo"], ["v", "bar"]],
]
```

```
["last",
  ["v", "foo", 2],
  ["v", "bar", 3],
  ["r", "add", "foo", "bar"],
]
```


```
["pass",
  ["v", "foo", 2],
  ["v", "bar", 3],
  ["v", "sum", ["r", "add", "foo", "bar"]],
  ["print", "string", "{0}+{1}={2}", [["r", 0], ["r", 1], ["r", 2]]
]
```

## Console

The console object (`oRunGML_Console`) provides a convenient way to debug and modify your game at runtime.

Console instances are persistent, but there can only be one instance at a time.  If you create a second it will destroy the first automatically.  Add one to your starting room and it will be usable throughout your game.

After creating an instance of oRunGML_Console, you can toggle it on and off by pressing `F9`.  This keybind can be changed by setting `global.RunGML_Console_toggleKey`, defined in `scrRunGML_Config`.

In RunGML code, the `"console"` operator facilitates interaction with the console instance, creating a new one first if needed.

When called with 0 arguments it returns the console instance's ID.  With one argument it gets an instance variable value, and with two arguments it sets a variable.

For example, the following two programs are equivalent ways of setting the console's text color to red:

```
['inst',  ['console'], 'text_color', ['rgb', 255, 0, 0]]
```

```
['console', 'text_color', ['rgb', 255, 0, 0]]
```

Note that the console gets its own instance of the RunGML interpreter.  When running RunGML code in the console, the `"parent"` operator is equivalent to the `"console"` operator.

### Console Syntax Differences

The console has some minor syntax conveniences that are not supported for programs stored in JSON files:
- It permits the use of single or double quotes, treating them idendically.
- It automatically adds a set of brackets around your command.

So while a hello world program stored as JSON looks like: `["print", "Hello, world!"]`

The equivalent console command can look like: `'print", "Hello, World'`

Combining quote types in this way is not advised.  Consistent use of single quotes in the console is probably fine.  Future updates may change the way quotation marks and escape characters are handled to improve consistency.

### Console-Specific Operators

- The `"clear"` operator will clear the console's history.
- The `"parent"` operator will return a reference to the console instance.

## Objects

This library includes two template objects, `oRunGML_Object` and `oRunGML_ObjectTemplate`.
- `oRunGML_Object` provides only barebones functionality and is not directly useful.
- `oRunGML_ObjectTemplate` inherits from `oRunGML_Object` and sets up most events to execute RunGML programs passed through the event dictionary of the `"object"` operator.

## Operator Definitions

See the [manual](manual.md) for full documentation of supported operators and aliases.

Custom operators *should* be defined in the `RunGML_ConfigOps()` function in the [scrRunGML_Config](src/scripts/scrRunGML_Config/scrRunGML_Config.gml) script, which includes an example definition for `"test_operator`" that can be copied as a template.

Custom operators *can* be defined anywhere, anytime by calling:
```
new RunGML_Op("operator_name",
    function(interpreter, argument_list){},
    "documentation string",
    [
        constraint0,
        constraint1,
        ...
    ]
);
```

The function definition in the second argument must take two arguments: an instance of the RunGML interpreter, and a list of arguments being passed to the operator.  The function definition can also be replaced with a string, number, asset reference, etc. to define a constant.

Custom aliases can be added from anywhere using RunGML_alias("nickname", "operator_name").  They also *should* be defined in RunGML_ConfigOps().

Documentation for custom operators and aliases will automatically become available via `"help"` and `"manual"`.
