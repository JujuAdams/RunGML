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
	global.RunGML_Config_overwrite = false; 
	
	// Define your own operators
	var op_defs = {
		"test": new RunGML_Op (
			// Define a function
			function(_i, _l) {
				// All operator functions take the same two arguments:
				// _i: A RunGML_Interpreter instance
				// _l: A list of arguments
				return "Hello, config!"
			},
			
			// Write documentation
			new RunGML_Doc(
				"test", // Name
				"Test operator", // Description
				"[]", // Arguments
				"string" // Output
			),
			
			// Specify constraints
			[
				new RunGML_Constraint_ArgCount("geq", 0)
			]
		),
		"test_constant": new RunGML_Op (
			42, // Operators can also return a constant value instead of executing a function
			new RunGML_Doc(
				"test_constant", // Name
				"Test constant", // Description
				"[]", // Arguments
				"42" // Output
			),
		)
	}
	
	// This adds your operators to the language
	struct_foreach(op_defs,
		function(_name, _value) {
			if global.RunGML_Config_overwrite or !struct_exists(global.RunGML_Ops, _name) {
				struct_set(global.RunGML_Ops, _name, _value);
			}
		}
	)
}
