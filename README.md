var _operator = array_shift(_l);# RunGML
A Lisp-like language embedded in GameMaker and programmed in JSON

## Overview

RunGML is a language that lets you modify GameMaker programs at runtime.
It has a Lisp-like syntax composed of nested **lists**, which may also contain **strings**, **numbers**, and **structs**.
This allows programs to be written in JSON, which allows GameMaker to import them from included files.

In addition to the language definition and interpreter, this library also includes:
- A template object with built-in events configured to run RunGML programs (created using the "object" operator)
- An interactive console for writing and running programs while a game is running.
- A test room, test object, and example included files to demonstrate basic functionality
- Documentation, available via the "help" operator

### RunGML Syntax

The simplest program is an empty list.
The simplest operator returns an empty list.

When a list is evaluated:
- An empty list returns nothing.
- Any elements that are lists will be evaluated first.
- If the first element is (or evaluates to) a string naming a supported operator, that operator will be applied to the remaining list elements and the result will be returned.
- Otherwise, the list of evaluated elements will be returned.

The basic syntax is:
`["operator_name", argument_0, argument_1, ...]`

For example:
`["print", "Hello, world!"]`

Using registers:
```
["pass",
  ["s", 0, 2],
  ["s", 1, 3],
  ["s", 2, ["add", ["r", 0], ["r", 1]]],
  ["print", "string", "{0}+{1}={2}", [["r", 0], ["r", 1], ["r", 2]]
]
```

Using register operators:
```
["pass",
  ["s", 0, 2],
  ["s", 1, 3],
  ["s", 2, ["r_add", 0, 1]],
  ["print", "r_string", "{0}+{1}={2}", 0, 1, 2]
]
```
This will print the string: `2+3=5`

### Console Syntax

The console has some minor syntax conveniences:
- It permits the use of single or double quotes, treating them idendically.
- It does not require brackets around the top-level list.

For example, this is a valid console command despite not being a valid JSON file:

```
'print", "Hello, World'
```

