// Start an interpreter
RunGMLI = new RunGML_Interpreter("Test");
//RunGMLI.debug = true

with(RunGMLI) {
	//run(["print", ["help"]]);
	
	// Run a single-line program
	run(["print", "Hello, world!"]);

	// Run a multi-line program
	run(["pass",
		["print", "Hello, multiverse!"],
		["print", "Hello, other multiverse!"]
	]);
	
	// Obtain output of each line in a multi-line program
	show_debug_message(run(["list",
		"Hello, multiple outputs!",
		["string", "{0}{1} output", 2, ["nth", 2]],
		["string", "{0}{1} output", 3, ["nth", 3]]
	]))
	
	// Obtain output from the last line in a multi-line program
	show_debug_message(run(["last",
		["v", 0, "Hello, "],
		["v", 1, "concatenation!"],
		["r", "add", 0, 1]
	]))
	
	// Run a program from a file
	run(["runfile", "RunGML/programs/examples/hello.txt"]);

	// Create an object from a file
	run(["runfile", "RunGML/programs/examples/object.txt"])

	// Run an example program
	run(["example", "math"]);

	//// Display a frame counter
	//run(["runfile", "RunGML/examples/counter.txt"]);
	
	// Create a RunGML console
	run(["console"]);
}