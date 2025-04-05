
# RunGML

Version: 2025_04_05_00

Homepage: https://github.com/sdelaughter/RunGML

Run ["update"] to visit the homepage to read documentation, check for updates, report bugs, or request features.

Run ["op_names"] to list all 131 supported operators.

Run ["help", "some_operator_name"] to get documentation on a specific operator.

Run ["manual"] to generate full documentation for all operators.


## Operators

- abs
    - desc: Returns the absolute value of a number
    - args: [number]
    - output: abs(number)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)

- add
    - desc: Add two or more numbers (use 'cat' or 'string' to combine strings)
    - args: [A, B]
    - output: A + B (+ ...)
    - constraints:
        - count(args) geq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- alias
    - desc: Create an operator alias. Behavior depends on the number of arguments:
        - 0: Return the interpreter's entire alias struct
        - 1: If the argument names an operator or alias, return a list of all synonyms starting with the real name.
        - 2: Creates a new alias with nickname arg0 for operator arg1.  arg0 cannot be in use, arg1 must be defined.
    - args: [(nickname), (name)]
    - output: struct or list
    - constraints:
        - count(args) leq 2
        - typeof(args[0]) in [ "string" ] (optional)
        - typeof(args[1]) in [ "string" ] (optional)

- and
    - desc: Logical and operator
    - args: [A, B]
    - output: A and B

- approach
    - desc: Increment a number by some amount while staying within a range
    - args: [number, increment, min, max]
    - output: [number]
    - constraints:
        - count(args) eq 4
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- array
    - desc: Create, read, or modify a struct. Behavior depends on the number of arguments:
        - 0: return an empty array
        - 1: returns [arg0]
        - 2: returns arg0[arg1]
        - 3: sets arg0[arg1] = arg2;
    - args: [(array), (index), (value)]
    - output: [*]

- array_get
    - desc: Return a value from an array by index.
    - args: [array, index]
    - output: value
    - constraints:
        - typeof(args[0]) in [ "array" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)

- asset
    - desc: Return the index of the named asset
    - args: [asset_name]
    - output: index
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- cat
    - desc: Concatenate arguments into a single string
    - args: [value, (...)]
    - output: [string]

- ceil
    - desc: Rounds a number up
    - args: [number]
    - output: ceil(number)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)

- choose
    - desc: Return a random element from a list.
    - args: [(max=1)]
    - output: number
    - constraints:
        - typeof(args[0]) in [ "array" ] (required)

- clamp
    - desc: Clamp a number between a minimum and maximum value
    - args: [number, min, max]
    - output: number
    - constraints:
        - count(args) eq 3
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- clear
    - desc: If run from a console, clear that console's history
    - args: []
    - output: instance
    - constraints:
        - count(args) eq 0

- color
    - desc: Create a color by name or hex code
    - args: [string]
    - output: color
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- color_inv
    - desc: Create a random color
    - args: []
    - output: color

- color_merge
    - desc: Merge two colors by some amount
    - args: [color1, color2, fraction]
    - output: color3
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "number","int32","int64" ] (required)

- color_rand
    - desc: Create a random color
    - args: []
    - output: color

- console
    - desc: Return a reference to the RunGML console, creating one if it doesn't exist
    - args: []
    - output: instance
    - constraints:
        - count(args) leq 2
        - typeof(args[0]) in [ "string" ] (optional)

- create
    - desc: Create a new object instance
    - args: [x, y, depth/layer_name, object_name]
    - output: [instance_id]
    - constraints:
        - count(args) eq 4
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "string","number","int32","int64" ] (required)
        - typeof(args[3]) in [ "string","number","int32","int64" ] (required)

- cursor
    - desc: Return the cursor's coordinates
    - args: []
    - output: [mouse_x, mouse_y]

- dec
    - desc: Decrement a variable by some amount.  If the variable is undefined, set it to that amount.
    - args: [register_name, number]
    - output: []
    - constraints:
        - count(args) eq 2
        - typeof(args[0]) in [ "string","number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)

- delta
    - desc: Return the time elapsed since the previous frame in seconds
    - args: []
    - output: number

- destroy
    - desc: Destroy an instance
    - args: [instance_id]
    - output: []

- display_h
    - desc: Returns the height of the display.
    - args: []
    - output: [height]

- display_w
    - desc: Returns the width of the display.
    - args: []
    - output: [width]

- div
    - aliases: [ "divide" ]
    - desc: Divide two numbers
    - args: [A, B]
    - output: A / B
    - constraints:
        - count(args) eq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- draw_alpha
    - desc: Get or set the draw alpha.
    - args: [(alpha)]
    - output: (alpha)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (optional)

- draw_circle
    - desc: Draw a circle
    - args: [x, y, (r=1), (outline=false), (c_center=draw_color), (c_edge=draw_color)]
    - output: []
    - constraints:
        - count(args) in [ 3,4,5,6 ]
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "number","int32","int64" ] (optional)
        - typeof(args[3]) in [ "bool" ] (optional)
        - typeof(args[4]) in [ "bool" ] (optional)

- draw_color
    - desc: Get or set the draw color.
    - args: [(color)]
    - output: (color)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (optional)

- draw_ellipse
    - desc: Draw an ellipse
    - args: [x1, y1, x2, y2, (outline=false), (c_center=draw_color), (c_edge=draw_color)]
    - output: []
    - constraints:
        - count(args) in [ 3,4,5,6 ]
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "number","int32","int64" ] (required)
        - typeof(args[3]) in [ "number","int32","int64" ] (required)
        - typeof(args[4]) in [ "bool" ] (optional)
        - typeof(args[5]) in [ "number","int32","int64" ] (optional)
        - typeof(args[6]) in [ "number","int32","int64" ] (optional)

- draw_font
    - desc: Get or set the draw font.
    - args: [(font)]
    - output: (font)
    - constraints:
        - count(args) leq 1

- draw_format
    - desc: Get or set the draw font, h_align, v_align, color, and alpha simultaneously.
    - args: [([font, h_align, v_align, color, alpha])]
    - output: ([font, h_align, v_align, color, alpha])
    - constraints:
        - count(args) leq 1

- draw_halign
    - desc: Get or set the horizontal draw alignment
    - args: [(value)]
    - output: (value)

- draw_line
    - desc: Draw a line
    - args: [x1, y1, x2, y2, (color), (color2)]
    - output: []
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "number","int32","int64" ] (required)
        - typeof(args[3]) in [ "number","int32","int64" ] (required)
        - typeof(args[4]) in [ "number","int32","int64" ] (optional)
        - typeof(args[5]) in [ "number","int32","int64" ] (optional)

- draw_point
    - desc: Draw a point
    - args: [x, y, (color)]
    - output: []
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "number","int32","int64" ] (optional)

- draw_rect
    - desc: Draw a rectangle
    - args: [x1, y1, x2, y2, (outline=false), (c1=draw_color), (c2=c1, c3=c1, c4=c1)]
    - output: []
    - constraints:
        - count(args) in [ 4,5,6,9 ]
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "number","int32","int64" ] (required)
        - typeof(args[3]) in [ "number","int32","int64" ] (required)
        - typeof(args[4]) in [ "bool" ] (optional)
        - typeof(args[5]) in [ "number","int32","int64" ] (optional)
        - typeof(args[6]) in [ "number","int32","int64" ] (optional)
        - typeof(args[7]) in [ "number","int32","int64" ] (optional)
        - typeof(args[8]) in [ "number","int32","int64" ] (optional)

- draw_sprite
    - desc: Draw a sprite
    - args: [sprite_index, frame, x, y]
    - output: []

- draw_sprite_general
    - desc: Draw a sprite using additional parameters
    - args: [sprite_index, frame, left, top, width, height, x, y, xscale, yscale, rot, c1, c2, c3, c4, alpha]
    - output: []

- draw_text
    - desc: Draw text
    - args: [x, y, string]
    - output: []
    - constraints:
        - count(args) eq 3
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "string" ] (required)

- draw_valign
    - desc: Get or set the vertical draw alignment
    - args: [(value)]
    - output: (value)

- e
    - desc: Return the value of the mathematical constant e
    - args: []
    - output: e (constant)
    - constraints:
        - count(args) eq 0

- eq
    - desc: Check whether two arguments are equivalent
    - args: [A, B]
    - output: [(A == B)]

- example
    - desc: Run an included example program
    - args: [example_program_name]
    - output: *
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- exec
    - desc: Execute a string as a program.
    - args: [string]
    - output: *
    - constraints:
        - count(args) eq 1
        - typeof(args[0]) in [ "string" ] (required)

- exp
    - desc: Raise e to some power
    - args: [number]
    - output: e ^ number
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)

- export
    - desc: Export JSON to a file
    - args: [path, data, (pretty=true)]
    - output: []
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)
        - typeof(args[1]) in [ "array","struct" ] (required)
        - typeof(args[2]) in [ "bool" ] (optional)

- false
    - aliases: [ "False" ]
    - desc: Return the GameMaker constant false
    - args: []
    - output: false (constant)
    - constraints:
        - count(args) eq 0

- floor
    - desc: Rounds a number down
    - args: [number]
    - output: floor(number)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)

- fps
    - desc: Get the current fps (capped at the room speed)
    - args: []
    - output: fps

- fps_real
    - desc: Get the current fps (not capped at the room speed)
    - args: []
    - output: fps_real

- frac
    - desc: Returns the fractional portion of a number
    - args: [number]
    - output: frac(number)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)

- fullscreen
    - desc: Toggle fullscreen mode.  Set status with a single boolean argument, or swap status with no arguments.
    - args: [(bool)]
    - output: []

- game_speed
    - desc: Get or set the game speed in terms of fps
    - args: [(game_speed)]
    - output: (game_speed)

- geq
    - desc: Check whether the first argument is greater than or equal to the second
    - args: [A, B]
    - output: [(A >= B)]

- global
    - aliases: [ "g" ]
    - desc: Create, read, or modify global variables. Behavior depends on the number of arguments:
        - 0: return an empty struct
        - 1: returns {'struct': arg0}
        - 2: returns get_struct(arg0, arg1)
    - args: []
    - output: []

- gm_version
    - desc: Returns the game's version number,
    - args: []
    - output: string (constant)
    - constraints:
        - count(args) eq 0

- gt
    - desc: Check whether the first argument is greater than the second
    - args: [A, B]
    - output: [(A > B)]

- help
    - desc: Display documentation for RunGML, or for an operator named by the first argument.
    - args: [(string)]
    - output: string
    - constraints:
        - count(args) leq 1
        - typeof(args[0]) in [ "string" ] (optional)

- hsv
    - desc: Create an HSV color
    - args: [hue, saturation, value]
    - output: color

- if
    - desc: Evaluate and act on a conditional
    - args: [conditional {'true': program, 'false': program}]
    - output: []
    - constraints:
        - typeof(args[0]) in [ "bool" ] (required)
        - typeof(args[1]) in [ "struct" ] (required)

- import
    - desc: Import JSON from a file
    - args: [filepath]
    - output: json
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- in
    - desc: Retrieve the output list from a struct produced by the 'out' operator.
    - args: [struct]
    - output: list
    - constraints:
        - typeof(args[0]) in [ "struct" ] (required)

- inc
    - desc: Increment a variable by some amount.  If the variable is undefined, set it to that amount.
    - args: [register_name, number]
    - output: []
    - constraints:
        - count(args) eq 2
        - typeof(args[0]) in [ "string","number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)

- inst
    - aliases: [ "i" ]
    - desc: Get and set instance variables. Behavior depends on the number of arguments:
        - 2: returns variable_instance_get(arg0, arg1)
        - 3: does variable_instance_set(arg0, arg1, arg2)
    - args: [instance, index, (value)]
    - output: *

- last
    - desc: Return the value of the last argument
    - args: [*]
    - output: *

- len
    - desc: Returns the length of a string, array, or struct.
    - args: [string/array/struct]
    - output: length

- leq
    - desc: Check whether the first argument is less than or equal to the second
    - args: [A, B]
    - output: [(A <= B)]

- lerp
    - desc: Lerp between two numbers by a given amount
    - args: [min, max, fraction]
    - output: number
    - constraints:
        - count(args) eq 3
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- list
    - desc: Return arguments as a list
    - args: []
    - output: []

- log
    - desc: Compute a logarithm.  Behavior depends on the number of arguments:
        - 0: Return the log of the argument in base 10
		- 1: Return the log of arg0 in the base of arg1
    - args: [number, (base=10)]
    - output: log_base(number)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (optional)

- lt
    - desc: Check whether the first argument is less than the second
    - args: [A, B]
    - output: [(A < B)]

- manual
    - desc: Write full documentation for all RunGML operators to a file and view it in the browser.
    - args: [(filename)]
    - output: []
    - constraints:
        - count(args) eq 0

- map_range
    - desc: Map a value proportionally from one range to another
    - args: [number, in_min, in_max, out_min, out_max]
    - output: number
    - constraints:
        - count(args) eq 5
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- max
    - desc: Return the larger of two numbers
    - args: [A, B]
    - output: max(A, B)
    - constraints:
        - count(args) eq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- min
    - desc: Return the smaller of two numbers
    - args: [A, B]
    - output: min(A, B)
    - constraints:
        - count(args) eq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- mod
    - desc: Modulo operator
    - args: [A, B]
    - output: A mod B
    - constraints:
        - count(args) eq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- mult
    - aliases: [ "multiply" ]
    - desc: Multiply two numbers
    - args: [A, B]
    - output: A * B
    - constraints:
        - count(args) eq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- near
    - desc: Return index of instance (arg2) nearest to some coordinates (arg0, arg1).
    - args: [(x=mouse_x), (y=mouse_y), (obj=any)]
    - output: index
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (optional)
        - typeof(args[0]) in [ "number","int32","int64" ] (optional)
        - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

- near_cursor
    - desc: Return index of instance nearest to the mouse.  Optional argument specifies an object index or asset name.
    - args: [(object_index/asset_name)]
    - output: index
    - constraints:
        - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

- neq
    - desc: Check whether two arguments are not equal (inverse of 'eq')
    - args: [A, B]
    - output: [(A != B)]

- noone
    - desc: Return the GameMaker constant noone
    - args: []
    - output: noone (constant)
    - constraints:
        - count(args) eq 0

- not
    - desc: Return the inverse of the argument's boolean value
    - args: [A]
    - output: [!A]

- nth
    - desc: Get the ordinal suffix for a given number
    - args: [number]
    - output: 'st', 'nd', 'rd', or 'th'

- object
    - aliases: [ "o" ]
    - desc: Create a new oRunGML_Object instance and return its index
    - args: [x, y, depth/layer_name, event_dictionary]
    - output: oRunGML_Object instance
    - constraints:
        - count(args) eq 4
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "number","int32","int64" ] (required)
        - typeof(args[2]) in [ "string","number","int32","int64" ] (required)
        - typeof(args[3]) in [ "struct" ] (required)

- op_count
    - desc: Returns the number of supported operators
    - args: []
    - output: number
    - constraints:
        - count(args) eq 0

- op_list
    - desc: Returns a list of supported operators
    - args: []
    - output: [string, *]
    - constraints:
        - count(args) eq 0

- op_names
    - desc: Returns a string listing names of supported operators
    - args: []
    - output: string
    - constraints:
        - count(args) eq 0

- or
    - desc: Logical or operator
    - args: [A, B]
    - output: [(A or B)]

- out
    - desc: Wrap argument list in a struct so it can be returned unevaluated.
    - args: [*]
    - output: struct

- parent
    - aliases: [ "p" ]
    - desc: Return a reference to the RunGML interpreter's parent object.
    - args: []
    - output: instance
    - constraints:
        - count(args) leq 2

- pass
    - desc: Do nothing
    - args: [*]
    - output: []

- phi
    - desc: Return the value of the mathematical constant phi
    - args: []
    - output: phi (constant)
    - constraints:
        - count(args) eq 0

- pi
    - desc: Return the value of the mathematical constant e
    - args: []
    - output: pi (constant)
    - constraints:
        - count(args) eq 0

- pow
    - desc: Raise one number to the power of another
    - args: [A, B]
    - output: A ^ B
    - constraints:
        - count(args) eq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- print
    - desc: Print a debug message
    - args: [stringable, (...)]
    - output: []

- prog
    - desc: Run arguments as programs
    - args: []
    - output: []
    - constraints:
        - typeof(args[0]) in [ "array" ] (required)

- quit
    - aliases: [ "q" ]
    - desc: Quit the game
    - args: []
    - output: []

- rand
    - desc: Return a random value.  Behavior depends on the number of arguments:
        - 0: Return a value between 0 and 1 (inclusive)
		- 1: Return a value between 0 and arg0 (inclusive)
		- 2: Return a value between arg0 and arg1 (inclusive)
    - args: [(max=1)]
    - output: number
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (optional)
        - typeof(args[1]) in [ "number","int32","int64" ] (optional)

- rand_int
    - desc: Return a random integer.  Behavior depends on the number of arguments:
        - 0: Return either 0 or 1
		- 1: Return an integer between 0 and arg0 (inclusive)
		- 2: Return an integer between arg0 and arg1 (inclusive)
    - args: [(max=1)]
    - output: number
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (optional)
        - typeof(args[1]) in [ "number","int32","int64" ] (optional)

- rand_seed
    - desc: Return a random value between 0 and some upper limit (defaults to 1).  Inclusive on both ends.
    - args: [(max=1)]
    - output: number
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (optional)

- reference
    - aliases: [ "r" ]
    - desc: Operate on referenced values.  Behavior depends on the number of arguments:
        - 0: Return the interpreter's registers struct (same as ['v'])
        - 1+: If the first argument names an operator:
            - Substitute any other arguments that name defined reigsters with their values.
            - Run the first-argument operator on the resulting list of substituted arguments.
            - For example, the following two programs are functionally equivalent:
                - ['r', 'add', 'foo', 'bar']
                - ['add', ['v', 'foo'], ['v', 'bar']]
            - They will return the sum of the values in registers 'foo' and 'bar'.
    - args: [(operator), (register_name, ...)]
    - output: *

- reference_parent
    - aliases: [ "rp" ]
    - desc: Similar to the 'reference' ('r') operator, but substitutes with values from the parent's instance variables.  Behavior depends on the number of arguments:
        - 0: Return the names of all parent instance variables
        - 1+: If the first argument names an operator:
            - Substitute any other arguments that name parent instance variables with their values
            - Run the first-argument operator on the resulting list of substituted arguments.
            - For example, the following two programs are functionally equivalent:
                - ['rp', 'add', 'foo', 'bar']
                - ['add', ['p', 'foo'], ['p', 'bar']]
            - They will return the sum of the values in parent instance variables 'foo' and 'bar'.
    - args: [(operator), (variable, ...)]
    - output: *

- repeat
    - desc: Repeat a function a fixed number of times
    - args: [count, program]
    - output: []
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)
        - typeof(args[1]) in [ "list" ] (required)

- rgb
    - desc: Create an RGB color
    - args: [red, green, blue]
    - output: color

- rickroll
    - desc: Got 'em!
    - args: []
    - output: []

- room
    - desc: Behavior depends on the number of arguments:
        - 0: Return the name of the current room
		- 1: Go to the named room, if it exists
    - args: [(room_name)]
    - output: [(room_name)]

- room_h
    - desc: Returns the height of the current room.
    - args: []
    - output: [height]

- room_next
    - desc: Go to the next room.
    - args: []
    - output: [height]

- room_w
    - desc: Returns the width of the current room.
    - args: []
    - output: [width]

- round
    - desc: Rounds a number
    - args: [number]
    - output: round(number)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)

- run
    - desc: Run arguments as a program.
    - args: [*]
    - output: *

- runfile
    - desc: Run a program from a file
    - args: [filepath]
    - output: *
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- runprog
    - desc: Run a program from a file in the incdlued RunGML/programs directory
    - args: [program_name]
    - output: *
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- shader
    - desc: Get or set the current shader. Zero arguments to get, one to set.
    - args: [(shader)]
    - output: [(shader)]
    - constraints:
        - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

- shader_reset
    - desc: Clear shaders
    - args: []
    - output: []

- sign
    - desc: Returns the sign of a number (1 if positive, -1 if negative)
    - args: [number]
    - output: sign(number)
    - constraints:
        - typeof(args[0]) in [ "number","int32","int64" ] (required)

- string
    - desc: Format a string
    - args: [template, (var0), ...]
    - output: [string]
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- struct
    - desc: Create, read, or modify a struct. Behavior depends on the number of arguments:
        - 0: return an empty struct
        - 1: returns {'struct': arg0}
        - 2: returns get_struct(arg0, arg1)
        - 3: returns set_struct(arg0, arg1, arg2);
    - args: []
    - output: []

- struct_keys
    - desc: Get a list of the keys in a struct
    - args: [struct]
    - output: [string, ...]

- sub
    - aliases: [ "subtract" ]
    - desc: Subtract two numbers
    - args: [A, B]
    - output: A - B
    - constraints:
        - count(args) eq 2
        - typeof(args[all]) in [ "number","int32","int64" ] (required)

- switch
    - desc: Perform switch/case evaluation
    - args: [value, {'case0': program, 'case1': program, 'default': program}]
    - output: []
    - constraints:
        - count(args) eq 2
        - typeof(args[1]) in [ "struct" ] (required)

- test_constant
    - desc:  (constant)

- test_operator
    - aliases: [ "test_alias" ]
    - desc: Test operator
	- args: []
	- output: string
    - constraints:
        - count(args) geq 0

- this
    - aliases: [ "t" ]
    - desc: Return a reference to the current RunGML interpreter
    - args: []
    - output: instance
    - constraints:
        - count(args) eq 0

- true
    - aliases: [ "True" ]
    - desc: Return the GameMaker constant true
    - args: []
    - output: true (constant)
    - constraints:
        - count(args) eq 0

- undefined
    - desc: Return the GameMaker constant undefined
    - args: []
    - output: undefined (constant)
    - constraints:
        - count(args) eq 0

- update
    - desc: Returns the RunGML web address
    - args: []
    - output: string
    - constraints:
        - count(args) eq 0

- url_open
    - desc: Open a URL in the default browser
    - args: [URL]
    - output: []
    - constraints:
        - typeof(args[0]) in [ "string" ] (required)

- var
    - aliases: [ "v" ]
    - desc: Get and set variables.  Behavior changes based on number of arguments:
        - 0: Returns the interpreter's entire registers struct.
        - 1: Returns the value saved in the named register.
        - 2: Sets the register named by the first argument to the value of the second argument.
    - args: [int] or [string]
    - output: *

- version
    - desc: Returns the RunGML version number
    - args: []
    - output: string (constant)
    - constraints:
        - count(args) eq 0

- while
    - desc: Exectue a function while a condition is true
    - args: [{'check': program, 'do': program}]
    - output: []
    - constraints:
        - typeof(args[0]) in [ "struct" ] (required)
