// Configure settings and define additional operators here

function RunGML_Config() {
	// Enable debug output?
	global.RunGML_I_debug = true;
	
	//Set lineheight for the console display
	global.RunGML_Console_lineHeight = 18;
	
	// Set the key to toggle the console on/off
	global.RunGML_Console_toggleKey = vk_f9;
	
	// Set the number of decimal places to display for floating point numbers in the console
	global.RunGML_Console_floatPrecision = 8;
	
	// Allow the operator definitions below to overwrite any built-ins with the same name?
	global.RunGML_Config_overwrite = true; 

	// Throw errors instead of just printing debug messages?
	global.RunGML_throwErrors = true;
	
	// Define your own operators
	new RunGML_Op ("test",
		function(_i, _l) {
			return "Hello, config!"
		},
@"Test operator
	- args: []
	- output: string",
		[new RunGML_Constraint_ArgCount("geq", 0)]
	)

	// Define your own constants
	new RunGML_Op ("test_constant", 42);
}
