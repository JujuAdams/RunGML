// Configure settings and define additional operators here

// Enable debug output for interpreters?
// Sets default behavior, can be changed for specific interpreter instances.
global.RunGML_I_debug = false;
	
//Set lineheight for the console display
global.RunGML_Console_lineHeight = 18;
	
// Set the key to toggle the console on/off
global.RunGML_Console_toggleKey = vk_f9;
	
// Set the number of decimal places to display for floating point numbers in the console
global.RunGML_Console_floatPrecision = 8;

//global.RunGML_Console_font = font_add_sprite(sprRunGML_Font_Pixel, ord("!"), false, 2);
global.RunGML_Console_font = fntRunGML_Console;

//global.RunGML_Console_font = font_add_sprite(sprRunGML_Font_Pixel, ord("!"), false, 2);
global.RunGML_Console_scale = 1.0;
	
// Allow new operator definitions to overwrite existing ones?
global.RunGML_overwriteOps = true;

// Throw errors instead of just printing debug messages?
// Sets default behavior, can be changed for specific interpreter instances.
// The console interpreter will throw to its display regardless.
global.RunGML_throwErrors = false;


// Define your own operators, aliases, and colors inside this function
function RunGML_ConfigOps() {
	/*An operator definition has the following parameters:
		- A name
		- A constant, or a function that accepts an interpreter instance and list of arguments
		- An optional documentation string
		- An optional list of constraints
	*/
	new RunGML_Op("test_operator",
		function(_i, _l) {
			return "Hello, Config!"
		},
@"Test operator
	- args: []
	- output: string",
		[new RunGML_Constraint_ArgCount("geq", 0)]
	)

	// Operators can also define constants instead of functions
	new RunGML_Op("test_constant", 42);

	// You can also define aliases for operators
	RunGML_alias("test_alias", "test_operator")
	
	// And define new color names for use with the "color" operator
	RunGML_color("seafoam", #78aa9f)
}
