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
	
// Allow the operator definitions below to overwrite any built-ins with the same name?
global.RunGML_Config_overwrite = true; 

// Throw errors instead of just printing debug messages?
// Sets default behavior, can be changed for specific interpreter instances.
// The console interpreter throws to its display.
global.RunGML_throwErrors = true;


// Define your own operators and aliases inside this function
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
	new RunGML_Op("test_constant", 42, "42");

	// You can also define aliases for operators
	RunGML_alias("test_alias", "test_operator")
}
