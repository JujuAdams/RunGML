This is an explanation of the [bounce](src/datafiles/RunGML/programs/examples/bounce.json) example program.

```json
["object", 0, 0, 0, {
```
At the top level, this program is creating a new instance of the [oRunGML_ObjectTemplate](src/objects/oRunGML_ObjectTemplate) object.
The `"object"` operator takes four arguments: x-position, y-position, layer/depth, and a dictionary of event defintions.
If the third argument is a string it will be interpreted as a layer name, while a number will be interpreted as a depth.
Events definitions are RunGML programs themselves, but wrapping them in a dictionary prevents those programs from being evaluated now.  They'll be stored in the object and run by it later, using its own dedicated instance of the RunGML interpreter.
So, we are creating an instance at x=0, y=0, depth=0, with the following event definitions...

```json
	"create": ["pass",
```
First define the object's Create event, which will be run immediately.
Starting with `"pass"` as the top-level operator means all other elements of the list will be evaluated and their outputs ignored. This is a common way to structure multi-line programs.

```json
		["rand_seed"],
```
Initialize random number generation.

```json
		["p", "x", ["div", ["display_gui_w"], 2.0]],
		["p", "y", ["div", ["display_gui_h"], 2.0]],
```
Set the object's `x` and `y` variables to the center of the display.
- The `"p"` operator is used to reference the parent of the RunGML interpreter executing the program, which in this case will be the oRunGML_ObjectTemplate instance we are creating.
- To make the object bounce around the *room* instead of the *screen*, we could replace all references to `"display_gui_(w/h)"` with `"room_(w/h)"`, and define a `"draw"` event instead of a `"draw_gui"` event below.

```json
		["if",
			["undefined", ["g", "RunGML_logoSprite"]], {
				"true": ["g", "RunGML_logoSprite", ["sprite", "RunGML/sprites/RunGML.png"]]
			}
		],
		["p", "sprite_index", ["g", "RunGML_logoSprite"]],
```
Set the object's sprite.  Create a new sprite from the included PNG and store a reference to it in a global variable, or use the existing sprite if the global is already defined.  This allows multiple copies of the program to be run without creating duplicate sprites.

```json
		["p", "image_speed", 0],
		["p", "image_blend", ["color_rand"]]
```
Set the sprite's animation speed to zero since it's a still image, and blend it with a random color.

```json
		["v", "_speed", 300],
		["v", "_dir", ["add", ["rand", 30, 60], ["mult", 90, ["choose", ["list", 0, 1, 2, 3]]]]],
		["p", "x_speed", ["r", "lendir_x", "_speed", "_dir"]],
		["p", "y_speed", ["r", "lendir_y", "_speed", "_dir"]],
```
Set a movement speed of 300 pixels/second, select a random direction around a diagonal (pick a random number between 30 and 60, and add it to a random multiple of 90), and compute the initial x- and y-velocities.  We use `"v"` instead of `"p"` here to set a register value in the interpreter rather than an instance variable for the object.  The `_speed` and `_dir` values are only used temporarily, we won't need to reference them again after creation.

```
	],
```
Close the list to end the create event definition.

```json
	"step": ["pass",
```
Next is the object's Step event.

```json
		["p", "x", ["add", ["p", "x"], ["mult", ["delta"], ["p", "x_speed"]]]],
```
First, increment the object's `x` variable by an amount equal to its `x_speed` multiplied by the time since the previous frame in seconds.

```json
		["if",
			["or",
				["lt", ["p", "bbox_left"], 0],
				["gt", ["p", "bbox_right"], ["display_gui_w"]]
			],{
				"true": ["pass",
					["p", "x_speed", ["mult", -1, ["p", "x_speed"]]],
					["p", "x", ["clamp", ["p", "x"], 1, ["sub", ["display_gui_w"], ["p", "sprite_width"]]]],
					["p", "image_blend", ["color_rand"]]
			]}
		],
```
Next is a conditional.  Check whether the object's bounding box is offscreen (`if bbox_left < 0 or bbox_right > display_get_gui_width()`).
If so, make it bounce in the opposite direction, clamp its position within the screen, and select a new random blend color.

```json
		["p", "y", ["add", ["p", "y"], ["mult", ["delta"], ["p", "y_speed"]]]],
		["if",
			["or",
				["lt", ["p", "bbox_top"], 0],
				["gt", ["p", "bbox_bottom"], ["display_gui_h"]]
			],{
				"true": ["pass",
					["p", "y_speed", ["mult", -1, ["p", "y_speed"]]],
					["p", "y", ["clamp", ["p", "y"], 1, ["sub", ["display_gui_h"], ["p", "sprite_height"]]]],
					["p", "image_blend", ["color_rand"]]
			]}
		],
```
Repeat the process for vertical movement.

```
	],
```
Close the list to complete the step event's definition.

```json
	"draw_gui": ["draw_self", ["p"]]
```
Finally, define a Draw GUI event for the object, which simply runs draw_self() as the parent object.

```
}]
```
Close the the event dictionary and the top-level list.


