// Start an interpreter
RunGMLI = new RunGML_Interpreter("Test");
//RunGMLI.debug = true

with(RunGMLI) {
	//run(["print", ["help"]]);
	
	// Run a single-line program
	show_debug_message("RunGML Test: Hello, RunGML?")
	run(["print", "Hello, RunGML!"]);

	show_debug_message("RunGML Test: Hello, multiple outputs?")
	// Obtain output of each line in a multi-line program
	show_debug_message(run(["list",
		"Hello, multiple outputs!",
		["string", "{0}{1} output", 2, ["nth", 2]],
		["string", "{0}{1} output", 3, ["nth", 3]]
	]))
	
	
	// Run a program from a file
	show_debug_message("RunGML Test: Hello, filesystem?")
	run(["runfile", "RunGML/programs/examples/hello.json"]);

	// Create an object from a file
	show_debug_message("RunGML Test: Hello, file object?")
	run(["runfile", "RunGML/programs/examples/object.json"])

	// Run an example program
	show_debug_message("RunGML Test: Hello, math? (2 +/-/*// 3)")
	run(["example", "math"]);
	
	// Create a clock
	show_debug_message("RunGML Test: Running clock example")
	run(["example", "clock"]);
	
	// Create a bouncer
	show_debug_message("RunGML Test: Running bounce_spr example")
	run(["example", "bounce_spr"]);
}