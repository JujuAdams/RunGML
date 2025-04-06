This is an explanation of the [bounce](src/datafiles/RunGML/programs/examples/bounce.json) example program.

```json
["object", 0, 0, 0, {
```
At the top level, this program is creating a new instance of the [oRunGML_ObjectTemplate](src/objects/oRunGML_ObjectTemplate) object.
The `"object"` operator takes four arguments: x-position, y-position, layer/depth, and a dictionary of event defintions.
If the third argument is a string it will be interpreted as a layer name, while a number will be interpreted as a depth.
So, we are creating an instance at x=0, y=0, depth=0, with the following event definitions...

```json
	"create": ["pass",
		["rand_seed"],
		["p", "x", ["rand_int", 0, ["display_gui_w"]]],
		["p", "y", ["rand_int", 0, ["display_gui_h"]]],
		["p", "r_x", 50],
		["p", "r_y", 30],
		["p", "border", 3],
		["v", "_speed", 300],
		["v", "_dir", ["add", ["rand", 30, 60], ["mult", 90, ["choose", ["list", 0, 1, 2, 3]]]]],
		["p", "x_speed", ["r", "lendir_x", "_speed", "_dir"]],
		["p", "y_speed", ["r", "lendir_y", "_speed", "_dir"]],
		["p", "color_A", ["color_rand"]],
		["p", "color_B", ["color_inv", ["p", "color_A"]]],
		["p", "text", "RunGML"]
	],
```
First define the object's Create event, which will be run immediately.
Starting with `"pass"` as the top-level operator means all other elements of the list will be evaluated and their outputs ignored. This is a common way to structure multi-line programs.

The body of the create function operates as follows:

- Set the object's `x` and `y` variables randomly within screenspace.
    - The `"p"` operator is used to reference the parent of the RunGML interpreter executing the program, which in this case will be the oRunGML_ObjectTemplate instance we are creating.
    - To make the object bounce around the *room* instead of the *screen*, we could replace `"display_gui_(w/h)"` with `"room_(w/h)"`, and define a `"draw"` event instead of a `"draw_gui"` event below.
- Define the horizontal and vertical radii for an ellipse.
- Set the outline width of the ellipse.
- Set a movemnt speed of 300 pixels/second.
    - We use `"v"` instead of `"p"` here to set a register value in the interpreter rather than an instance variable for the object.  This value is only used temporarily, we won't need to reference it again after creation.
- Select a random starting direction around a diagonal (pick a random number between 30 and 60, and add it to a random multiple of 90).
- Compute the initial x- and y-velocities based on the starting speed and direction.
- Create a random color.
- Create the inverse of that color.
- Define a text string to be displayed.

```json
	"step": ["pass",
```
Next is the object's Step event.  Let's look at this in a few separate chunks.

```json
		["p", "x", ["add", ["p", "x"], ["mult", ["delta"], ["p", "x_speed"]]]],
```
First, increment the object's `x` variable by an amount equal to its `x_speed` multiplied by the time since the previous frame in seconds.

```json
		["if",
			["or",
				["lt", ["p", "x"], 0],
				["gt", ["p", "x"], ["display_gui_w"]]
			],{
				"true": ["pass",
					["p", "x_speed", ["mult", -1, ["p", "x_speed"]]],
					["p", "x", ["clamp", ["p", "x"], 0, ["display_gui_w"]]],
					["p", "color_A", ["color_rand"]],
					["p", "color_B", ["color_inv", ["p", "color_A"]]]
			]}
		],
```
Next, check whether the object is outside the bounds of the screen (`if x < 0 or x > display_get_gui_width()`).
If so, do the follwing:
- Multiply `x_speed` by -1 to change directions
- Clamp `x` within the bounds
- Pick a new random color and find its inverse

```json
		["p", "y", ["add", ["p", "y"], ["mult", ["delta"], ["p", "y_speed"]]]],
		["if",
			["or",
				["lt", ["p", "y"], 0],
				["gt", ["p", "y"], ["display_gui_h"]]
			],{
				"true": ["pass",
					["p", "y_speed", ["mult", -1, ["p", "y_speed"]]],
					["p", "y", ["clamp", ["p", "y"], 0, ["display_gui_h"]]],
					["p", "color_A", ["color_rand"]],
					["p", "color_B", ["color_inv", ["p", "color_A"]]]
			]}
		],
	],
```
Then repeat the process for vertical movement to complete the step event.

```json
	"draw_gui": ["pass",
```
Finally, define a Draw GUI event for the object, starting with `"pass"` as usual.

```json
		["draw_ellipse", 
			["sub", ["p", "x"], ["rp", "add", "r_x", "border"]],
			["sub", ["p", "y"], ["rp", "add", "r_y", "border"]],
			["add", ["p", "x"], ["rp", "add", "r_x", "border"]],
			["add", ["p", "y"], ["rp", "add", "r_y", "border"]],
			["false"],
			["p", "color_A"]
		],
```

Draw an ellipse in the first color with the border width added to its radii.  This will be the outline.

Preceding an operator with `"rp"` will substitute string arguments for the value of parent instance variables named by those strings, where applicable. So `["rp", "add", "r_x", "border"]` is equivalent to `["add", ["p", "r_x"], ["p", "border"]],`

```json
		["draw_ellipse", 
			["rp", "sub", "x", "r_x"],
			["rp", "sub", "y", "r_y"],
			["rp", "add", "x", "r_x"],
			["rp", "add", "y", "r_y"],
			["false"],
			["p", "color_B"]
		],
```

Draw a second ellipse in the inverse color with the normal radii.

```json
		["v", "_old_format", ["draw_format"]],
		["draw_color", ["p", "color_A"]],
		["draw_halign", "center"],
		["draw_valign", "middle"],
		["draw_font", "fntRunGML_Console"],

```
- Create a backup of the current draw formatting, then set the draw color, horizontal alignment, vertical alignment, and font.

```json
		["rp", "draw_text", "x", "y", "text"],
		["r", "draw_format", "_old_format"]
	]
}]
```

Draw the text string at the center of the ellipse, then restore the prior draw formatting from the backup.
