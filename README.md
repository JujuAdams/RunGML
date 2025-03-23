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
- Thorough documentation that can be read in [`scrRunGML`](src/scripts/scrRunGML/scrRunGML.gml) or accessed using `"help"` and `"manual`"

## Running Programs

First create an instance of the RunGML interpreter:
`RunGMLI = new RunGML_Interpreter()`

Then you can pass your program as a list:
`RunGMLI.run(["print", "Hello, world!"])`

You can also execute programs that are stored in JSON files:
`RunGMLI.runfile(["filepath"])`

Programs should be stored with a `.txt` extension instead of `.json`.

Programs stored in `[included files directory]/RunGML/programs/` can be quickly run by name (excluding the extension):
`RunGMLI.runfile(["filename"])`

You can also write and run code from within your game using the console (see below).

## Syntax

Every program is a list.

The simplest program is: `[]`

The simplest operator (`"pass"`) is: `function(arg_list){return []}`

In addition to lists there are also strings, numbers, and structs.

### List Evaluation Rules

- An empty list returns nothing.
- Any list elements that are lists will be evaluated first (recursively).
- If the first element is (or evaluates to) a string naming an operator, that operator will be applied to any remaining elements and the result will be returned.
- Otherwise, the first element itself will be returned.



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

In RunGML code, the `"console"` operator will return a reference to the console instance, creating a new one first if needed.

The console gets its own instance of the RunGML interpreter.  When running RunGML code in the console, the `"parent"` operator will return a reference to the console instance.

You can modify the console at runtime just like any other object instance.  For example, the following program will set the console's text color to red:

```
['inst',  ['console'], 'text_color', ['rgb', 255, 0, 0]]
```

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
- `oRunGML_Object` provides only barebones functionality


