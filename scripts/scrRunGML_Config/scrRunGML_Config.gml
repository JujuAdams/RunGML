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
			function() {
				return "Hello, config!"
			}, new RunGML_Doc(
				"test",
				"Test operator",
				"[]",
				"string"
			)
		)
	}
	
	// (Adding your operators to the language)
	struct_foreach(op_defs,
		function(_name, _value) {
			if global.RunGML_Config_overwrite or !struct_exists(global.RunGML_Ops, _name) {
				struct_set(global.RunGML_Ops, _name, _value);
			}
		}
	)
}
