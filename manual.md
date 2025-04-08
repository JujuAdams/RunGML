# RunGML Manual

## About

Version: 2025_04_05_00

Homepage: https://github.com/sdelaughter/RunGML

## Operators & *Aliases*
[*False*](#false), [*True*](#true), [abs](#abs), [add](#add), [alias](#alias), [and](#and), [approach](#approach), [array](#array), [array_get](#array_get), [asset](#asset), [cat](#cat), [ceil](#ceil), [choose](#choose), [clamp](#clamp), [clear](#clear), [color](#color), [color_inv](#color_inv), [color_merge](#color_merge), [color_rand](#color_rand), [console](#console), [create](#create), [cursor](#cursor), [dec](#dec), [delta](#delta), [destroy](#destroy), [display_gui_h](#display_gui_h), [display_gui_w](#display_gui_w), [display_h](#display_h), [display_w](#display_w), [div](#div), [*divide*](#div), [do](#do), [draw_alpha](#draw_alpha), [draw_circle](#draw_circle), [draw_color](#draw_color), [draw_ellipse](#draw_ellipse), [draw_font](#draw_font), [draw_format](#draw_format), [draw_halign](#draw_halign), [draw_line](#draw_line), [draw_point](#draw_point), [draw_rect](#draw_rect), [draw_sprite](#draw_sprite), [draw_sprite_general](#draw_sprite_general), [draw_text](#draw_text), [draw_valign](#draw_valign), [e](#e), [eq](#eq), [example](#example), [exec](#exec), [exp](#exp), [export](#export), [false](#false), [floor](#floor), [fps](#fps), [fps_real](#fps_real), [frac](#frac), [fullscreen](#fullscreen), [*g*](#global), [game_speed](#game_speed), [geq](#geq), [global](#global), [gm_version](#gm_version), [gt](#gt), [help](#help), [hsv](#hsv), [*i*](#inst), [if](#if), [import](#import), [in](#in), [inc](#inc), [inst](#inst), [*l*](#list), [last](#last), [len](#len), [lendir_x](#lendir_x), [lendir_y](#lendir_y), [leq](#leq), [lerp](#lerp), [list](#list), [log](#log), [lt](#lt), [manual](#manual), [map_range](#map_range), [max](#max), [min](#min), [mod](#mod), [mult](#mult), [*multiply*](#mult), [near](#near), [near_cursor](#near_cursor), [neq](#neq), [noone](#noone), [not](#not), [nth](#nth), [*o*](#object), [object](#object), [op_count](#op_count), [op_list](#op_list), [op_names](#op_names), [or](#or), [out](#out), [*p*](#parent), [parent](#parent), [pass](#pass), [phi](#phi), [pi](#pi), [point_dir](#point_dir), [point_dist](#point_dist), [pow](#pow), [print](#print), [prog](#prog), [*q*](#quit), [quit](#quit), [*r*](#reference), [rand](#rand), [rand_int](#rand_int), [rand_seed](#rand_seed), [reference](#reference), [reference_parent](#reference_parent), [repeat](#repeat), [rgb](#rgb), [rickroll](#rickroll), [room](#room), [room_h](#room_h), [room_next](#room_next), [room_w](#room_w), [round](#round), [*rp*](#reference_parent), [run](#run), [runfile](#runfile), [runprog](#runprog), [shader](#shader), [shader_reset](#shader_reset), [sign](#sign), [string](#string), [struct](#struct), [struct_keys](#struct_keys), [sub](#sub), [*subtract*](#sub), [switch](#switch), [*t*](#this), [*test_alias*](#test_operator), [test_constant](#test_constant), [test_operator](#test_operator), [this](#this), [true](#true), [type](#type), [undefined](#undefined), [update](#update), [url_open](#url_open), [*v*](#var), [var](#var), [version](#version), [while](#while)

## Operator Documentation

### abs
Returns the absolute value of a number
- args: [number]
- output: abs(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)

### add
Add two or more numbers (use 'cat' or 'string' to combine strings)
- args: [A, B]
- output: A + B (+ ...)
- constraints:
    - count(args) geq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### alias
Create an operator alias. Behavior depends on the number of arguments:

0. Return the interpreter's entire alias struct
1. If the argument names an operator or alias, return a list of all synonyms starting with the real name.
2. Creates a new alias with nickname arg0 for operator arg1.  arg0 cannot be in use, arg1 must be defined.
	
- args: [(nickname), (name)]
- output: struct or list
- constraints:
    - count(args) leq 2
    - typeof(args[0]) in [ "string" ] (optional)
    - typeof(args[1]) in [ "string" ] (optional)

### and
Logical and operator
    - args: [A, B]
    - output: A and B

### approach
Increment a number by some amount while staying within a range
- args: [number, increment, min, max]
- output: [number]
- constraints:
    - count(args) eq 4
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### array
Create, read, or modify a struct. Behavior depends on the number of arguments:

0. Return an empty array
1. Return [arg0]
2. Return arg0[arg1]
3. Set arg0[arg1] = arg2;
- args: [(array), (index), (value)]
- output: [*]

### array_get
Return a value from an array by index.
- args: [array, index]
- output: value
- constraints:
    - typeof(args[0]) in [ "array" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)

### asset
Return the index of the named asset
- args: [asset_name]
- output: index
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### cat
Concatenate arguments into a single string
    - args: [value, (...)]
    - output: [string]

### ceil
Rounds a number up
- args: [number]
- output: ceil(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)

### choose
Return a random element from a list.
- args: [(max=1)]
- output: number
- constraints:
    - typeof(args[0]) in [ "array" ] (required)

### clamp
Clamp a number between a minimum and maximum value
- args: [number, min, max]
- output: number
- constraints:
    - count(args) eq 3
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### clear
If run from a console, clear that console's history
- args: []
- output: instance
- constraints:
    - count(args) eq 0

### color
Create a color by name or hex code
- args: [string]
- output: color
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### color_inv
Create a random color
- args: []
- output: color

### color_merge
Merge two colors by some amount
- args: [color1, color2, fraction]
- output: color3
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (required)

### color_rand
Create a random color
- args: []
- output: color

### console
Return a reference to the RunGML console, creating one if it doesn't exist
- args: []
- output: instance
- constraints:
    - count(args) leq 2
    - typeof(args[0]) in [ "string" ] (optional)

### create
Create a new object instance
- args: [x, y, depth/layer_name, object_name]
- output: [instance_id]
- constraints:
    - count(args) eq 4
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[3]) in [ "string","number","int32","int64" ] (required)

### cursor
Return the cursor's coordinates
- args: []
- output: [mouse_x, mouse_y]

### dec
Decrement a variable by some amount.  If the variable is undefined, set it to that amount.
- args: [register_name, number]
- output: []
- constraints:
    - count(args) eq 2
    - typeof(args[0]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)

### delta
Return the time elapsed since the previous frame in seconds
- args: []
- output: number

### destroy
Destroy an instance
- args: [instance_id]
- output: []

### display_gui_h
Returns the height of the display GUI.
    - args: []
    - output: [height]

### display_gui_w
Returns the width of the display GUI.
    - args: []
    - output: [width]

### display_h
Returns the height of the display.
    - args: []
    - output: [height]

### display_w
Returns the width of the display.
    - args: []
    - output: [width]

### div
Divide two numbers
- args: [A, B]
- output: A / B
- aliases: [ "divide" ]
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### do
Execute a function
- args: [function, ([args])]
- output: *
- constraints:
    - typeof(args[0]) in [ "method" ] (required)
    - typeof(args[1]) in [ "array" ] (optional)

### draw_alpha
Get or set the draw alpha.
- args: [(alpha)]
- output: (alpha)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)

### draw_circle
Draw a circle
- args: [x, y, (r=1), (outline=false), (c_center=draw_color), (c_edge=draw_color)]
- output: []
- constraints:
    - count(args) in [ 3,4,5,6 ]
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (optional)
    - typeof(args[3]) in [ "bool" ] (optional)
    - typeof(args[4]) in [ "bool" ] (optional)

### draw_color
Get or set the draw color.
- args: [(color)]
- output: (color)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)

### draw_ellipse
Draw an ellipse
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

### draw_font
Get or set the draw font.
- args: [(font name or asset reference)]
- output: (font asset reference)
- constraints:
    - typeof(args[0]) in [ "string","ref" ] (required)

### draw_format
Get or set the draw font, horizontal alignment, vertical alignment, color, and alpha simultaneously.  Use to backup/restore settings before/after drawing to isolate changes.
- args: [([font, h_align, v_align, color, alpha])]
- output: ([font, h_align, v_align, color, alpha])
- constraints:
    - count(args) leq 1

### draw_halign
Get or set the horizontal draw alignment
- args: [(value)]
- output: (value)

### draw_line
Draw a line
- args: [x1, y1, x2, y2, (color), (color2)]
- output: []
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (required)
    - typeof(args[3]) in [ "number","int32","int64" ] (required)
    - typeof(args[4]) in [ "number","int32","int64" ] (optional)
    - typeof(args[5]) in [ "number","int32","int64" ] (optional)

### draw_point
Draw a point
- args: [x, y, (color)]
- output: []
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (optional)

### draw_rect
Draw a rectangle
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

### draw_sprite
Draw a sprite
- args: [sprite_index, frame, x, y]
- output: []

### draw_sprite_general
Draw a sprite using additional parameters
- args: [sprite_index, frame, left, top, width, height, x, y, xscale, yscale, rot, c1, c2, c3, c4, alpha]
- output: []

### draw_text
Draw text
- args: [x, y, string]
- output: []
- constraints:
    - count(args) eq 3
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "string" ] (required)

### draw_valign
Get or set the vertical draw alignment
- args: [(value)]
- output: (value)

### e
Return the value of the mathematical constant e
- args: []
- output: e (constant)
- constraints:
    - count(args) eq 0

### eq
Check whether two arguments are equivalent
    - args: [A, B]
    - output: [(A == B)]

### example
Run an included example program
- args: [example_program_name]
- output: *
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### exec
Execute a string as a program.
- args: [string]
- output: *
- constraints:
    - count(args) eq 1
    - typeof(args[0]) in [ "string" ] (required)

### exp
Raise e to some power
- args: [number]
- output: e ^ number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)

### export
Export JSON to a file
- args: [path, data, (pretty=true)]
- output: []
- constraints:
    - typeof(args[0]) in [ "string" ] (required)
    - typeof(args[1]) in [ "array","struct" ] (required)
    - typeof(args[2]) in [ "bool" ] (optional)

### false
Return the GameMaker constant false
- args: []
- output: false (constant)
- aliases: [ "False" ]
- constraints:
    - count(args) eq 0

### floor
Rounds a number down
- args: [number]
- output: floor(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)

### fps
Get the current fps (capped at the room speed)
- args: []
- output: fps

### fps_real
Get the current fps (not capped at the room speed)
- args: []
- output: fps_real

### frac
Returns the fractional portion of a number
- args: [number]
- output: frac(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)

### fullscreen
Toggle fullscreen mode.  Set status with a single boolean argument, or swap status with no arguments.
    - args: [(bool)]
    - output: []

### game_speed
Get or set the game speed in terms of fps
- args: [(game_speed)]
- output: (game_speed)

### geq
Check whether the first argument is greater than or equal to the second
    - args: [A, B]
    - output: [(A >= B)]

### global
Create, read, or modify global variables. Behavior depends on the number of arguments:

0. Return an empty struct
1. Return {'struct': arg0}
2. Return get_struct(arg0, arg1)
- args: []
- output: []
- aliases: [ "g" ]

### gm_version
Returns the game's version number,
- args: []
- output: string (constant)
- constraints:
    - count(args) eq 0

### gt
Check whether the first argument is greater than the second
    - args: [A, B]
    - output: [(A > B)]

### help
Display documentation for RunGML, or for an operator named by the first argument.
- args: [(string)]
- output: string
- constraints:
    - count(args) leq 1
    - typeof(args[0]) in [ "string" ] (optional)

### hsv
Create an HSV color
- args: [hue, saturation, value]
- output: color

### if
Evaluate and act on a conditional
- args: [conditional {'true': program, 'false': program}]
- output: []
- constraints:
    - typeof(args[0]) in [ "bool" ] (required)
    - typeof(args[1]) in [ "struct" ] (required)

### import
Import JSON from a file
- args: [filepath]
- output: json
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### in
Retrieve the output list from a struct produced by the 'out' operator.
- args: [struct]
- output: list
- constraints:
    - typeof(args[0]) in [ "struct" ] (required)

### inc
Increment a variable by some amount.  If the variable is undefined, set it to that amount.
- args: [register_name, number]
- output: []
- constraints:
    - count(args) eq 2
    - typeof(args[0]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)

### inst
Get and set instance variables. Behavior depends on the number of arguments:

2. Return variable_instance_get(arg0, arg1)
3. Do variable_instance_set(arg0, arg1, arg2)
- args: [instance, index, (value)]
- output: *
- aliases: [ "i" ]

### last
Return the value of the last argument
- args: [*]
- output: *

### len
Returns the length of a string, array, or struct.
- args: [string/array/struct]
- output: length

### lendir_x
Find the x component for a given vector
- args: [length, direction]
- output: x_component

### lendir_y
Find the y component for a given vector
- args: [length, direction]
- output: y_component

### leq
Check whether the first argument is less than or equal to the second
    - args: [A, B]
    - output: [(A <= B)]

### lerp
Lerp between two numbers by a given amount
- args: [min, max, fraction]
- output: number
- constraints:
    - count(args) eq 3
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### list
Return arguments as a list
- args: []
- output: []
- aliases: [ "l" ]

### log
Compute a logarithm.  Behavior depends on the number of arguments:

0. Return the log of the argument in base 10
1. Return the log of arg0 in the base of arg1
- args: [number, (base=10)]
- output: log_base(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### lt
Check whether the first argument is less than the second
    - args: [A, B]
    - output: [(A < B)]

### manual
Generate full markdown-formatted documentation for all RunGML operators and view it in the browser.
- args: [(filename='RunGML/manual.md')]
- output: []
- constraints:
    - count(args) eq 0

### map_range
Map a value proportionally from one range to another
- args: [number, in_min, in_max, out_min, out_max]
- output: number
- constraints:
    - count(args) eq 5
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### max
Return the larger of two numbers
- args: [A, B]
- output: max(A, B)
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### min
Return the smaller of two numbers
- args: [A, B]
- output: min(A, B)
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### mod
Modulo operator
- args: [A, B]
- output: A mod B
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### mult
Multiply two numbers
- args: [A, B]
- output: A * B
- aliases: [ "multiply" ]
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### near
Return index of instance (arg2) nearest to some coordinates (arg0, arg1).
- args: [(x=mouse_x), (y=mouse_y), (obj=any)]
- output: index
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

### near_cursor
Return index of instance nearest to the mouse.  Optional argument specifies an object index or asset name.
- args: [(object_index/asset_name)]
- output: index
- constraints:
    - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

### neq
Check whether two arguments are not equal (inverse of 'eq')
    - args: [A, B]
    - output: [(A != B)]

### noone
Return the GameMaker constant noone
- args: []
- output: noone (constant)
- constraints:
    - count(args) eq 0

### not
Return the inverse of the argument's boolean value
    - args: [A]
    - output: [!A]

### nth
Get the ordinal suffix for a given number
- args: [number]
- output: 'st', 'nd', 'rd', or 'th'

### object
Create a new oRunGML_Object instance and return its index
- args: [x, y, depth/layer_name, event_dictionary]
- output: oRunGML_Object instance
- aliases: [ "o" ]
- constraints:
    - count(args) eq 4
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[3]) in [ "struct" ] (required)

### op_count
Returns the number of supported operators
- args: []
- output: number
- constraints:
    - count(args) eq 0

### op_list
Returns a list of supported operators
- args: []
- output: [string, *]
- constraints:
    - count(args) eq 0

### op_names
Returns a string listing names of supported operators
- args: []
- output: string
- constraints:
    - count(args) eq 0

### or
Logical or operator
    - args: [A, B]
    - output: [(A or B)]

### out
Wrap argument list in a struct so it can be returned unevaluated.
- args: [*]
- output: struct

### parent
Return a reference to the RunGML interpreter's parent object.
- args: []
- output: instance
- aliases: [ "p" ]
- constraints:
    - count(args) leq 2

### pass
Do nothing
- args: [*]
- output: []

### phi
Return the value of the mathematical constant phi
- args: []
- output: phi (constant)
- constraints:
    - count(args) eq 0

### pi
Return the value of the mathematical constant e
- args: []
- output: pi (constant)
- constraints:
    - count(args) eq 0

### point_dir
Find the direction from one point to another
- args: [x1, y1, x2, y2]
- output: distance

### point_dist
Find the distance between two points
- args: [x1, y1, x2, y2]
- output: distance

### pow
Raise one number to the power of another
- args: [A, B]
- output: A ^ B
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### print
Print a debug message
    - args: [stringable, (...)]
    - output: []

### prog
Run arguments as programs
- args: []
- output: []
- constraints:
    - typeof(args[0]) in [ "array" ] (required)

### quit
Quit the game
- args: []
- output: []
- aliases: [ "q" ]

### rand
Return a random value.  Behavior depends on the number of arguments:
0. Return a value between 0 and 1 (inclusive)
1. Return a value between 0 and arg0 (inclusive)
2. Return a value between arg0 and arg1 (inclusive)
- args: [(max=1)]
- output: number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### rand_int
Return a random integer.  Behavior depends on the number of arguments:
0. Return either 0 or 1
1. Return an integer between 0 and arg0 (inclusive)
2. Return an integer between arg0 and arg1 (inclusive)
- args: [(max=1)]
- output: number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### rand_seed
Return a random value between 0 and some upper limit (defaults to 1).  Inclusive on both ends.
- args: [(max=1)]
- output: number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)

### reference
Operate on referenced values.  Behavior depends on the number of arguments:

0. Return the interpreter's registers struct (same as ['v'])
1. (or more) If the first argument names an operator:
    - Substitute any other arguments that name defined reigsters with their values.
    - Run the first-argument operator on the resulting list of substituted arguments.
    - For example, the following two programs are functionally equivalent:
        - ['r', 'add', 'foo', 'bar']
        - ['add', ['v', 'foo'], ['v', 'bar']]
    - They will return the sum of the values in registers 'foo' and 'bar'.
- args: [(operator), (register_name, ...)]
- output: *
- aliases: [ "r" ]

### reference_parent
Similar to the 'reference' ('r') operator, but substitutes with values from the parent's instance variables.  Behavior depends on the number of arguments:

0. Return the names of all parent instance variables
1. (or more) If the first argument names an operator:
    - Substitute any other arguments that name parent instance variables with their values
    - Run the first-argument operator on the resulting list of substituted arguments.
    - For example, the following two programs are functionally equivalent:
        - ['rp', 'add', 'foo', 'bar']
        - ['add', ['p', 'foo'], ['p', 'bar']]
    - They will return the sum of the values in parent instance variables 'foo' and 'bar'.
- args: [(operator), (variable, ...)]
- output: *
- aliases: [ "rp" ]

### repeat
Repeat a function a fixed number of times
- args: [count, program]
- output: []
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "list" ] (required)

### rgb
Create an RGB color
- args: [red, green, blue]
- output: color

### rickroll
Got 'em!
- args: []
- output: []

### room
Behavior depends on the number of arguments:

0. Return the name of the current room
1. Go to the named room, if it exists
    - args: [(room_name)]
    - output: [(room_name)]

### room_h
Returns the height of the current room.
    - args: []
    - output: [height]

### room_next
Go to the next room.
    - args: []
    - output: [height]

### room_w
Returns the width of the current room.
    - args: []
    - output: [width]

### round
Rounds a number
- args: [number]
- output: round(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)

### run
Run arguments as a program.
- args: [*]
- output: *

### runfile
Run a program from a file
- args: [filepath]
- output: *
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### runprog
Run a program from a file in the incdlued RunGML/programs directory
- args: [program_name]
- output: *
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### shader
Get or set the current shader. Zero arguments to get, one to set.
    - args: [(shader)]
    - output: [(shader)]
- constraints:
    - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

### shader_reset
Clear shaders
    - args: []
    - output: []

### sign
Returns the sign of a number (1 if positive, -1 if negative)
- args: [number]
- output: sign(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)

### string
Format a string
    - args: [template, (var0), ...]
    - output: [string]
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### struct
Create, read, or modify a struct. Behavior depends on the number of arguments:

0. Return an empty struct
1. Return {'struct': arg0}
2. Return get_struct(arg0, arg1)
3. Return set_struct(arg0, arg1, arg2);
- args: []
- output: []

### struct_keys
Get a list of the keys in a struct
- args: [struct]
- output: [string, ...]

### sub
Subtract two numbers
- args: [A, B]
- output: A - B
- aliases: [ "subtract" ]
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### switch
Perform switch/case evaluation
- args: [value, {'case0': program, 'case1': program, 'default': program}]
- output: []
- constraints:
    - count(args) eq 2
    - typeof(args[1]) in [ "struct" ] (required)

### test_constant
 (constant)

### test_operator
Test operator
- args: []
- output: string
- aliases: [ "test_alias" ]
- constraints:
    - count(args) geq 0

### this
Return a reference to the current RunGML interpreter
- args: []
- output: instance
- aliases: [ "t" ]
- constraints:
    - count(args) eq 0

### true
Return the GameMaker constant true
- args: []
- output: true (constant)
- aliases: [ "True" ]
- constraints:
    - count(args) eq 0

### type
Return the type of a variable
- args: [*]
- output: type_name
- constraints:
    - count(args) eq 1

### undefined
Return the GameMaker constant undefined
- args: []
- output: undefined (constant)
- constraints:
    - count(args) eq 0

### update
Returns the RunGML web address
- args: []
- output: string
- constraints:
    - count(args) eq 0

### url_open
Open a URL in the default browser
    - args: [URL]
    - output: []
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### var
Get and set variables.  Behavior changes based on number of arguments:

0. Return the interpreter's entire registers struct.
1. Return the value saved in the named register.
2. Set the register named by the first argument to the value of the second argument.
- args: [int] or [string]
- output: *
- aliases: [ "v" ]

### version
Returns the RunGML version number
- args: []
- output: string (constant)
- constraints:
    - count(args) eq 0

### while
Exectue a function while a condition is true
- args: [{'check': program, 'do': program}]
- output: []
- constraints:
    - typeof(args[0]) in [ "struct" ] (required)
