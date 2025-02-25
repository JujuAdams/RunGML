// Start an interpreter
RunGMLI = new RunGML_Interpreter("Test");
with(RunGMLI) {
	show_debug_message(run("foo"));
	
	run(["print", ["help"]]);
	
	//debug = true;
	// Run a single-line program
	run(["print", "Hello, world!"]);

	// Run a multi-line program
	run(["pass",
		["print", "Hello, multiverse!"],
		["print", "Hello, other multiverse!"]
	]);
	
	// Obtain output from a multi-line program
	show_debug_message(run(["out",
		"Hello, output!",
		["string", "{0}{1} output", 2, ["nth", 2]],
		["string", "{0}{1} output", 3, ["nth", 3]]
	]))
	
	// Run a program from a file
	run(["runfile", "RunGML/examples/hello.txt"]);

	// Create an object from a file
	run(["runfile", "RunGML/examples/object.txt"])

	// Do some math
	run(["runfile", "RunGML/examples/math.txt"]);

	//// Display a frame counter
	//run(["runfile", "RunGML/examples/counter.txt"]);
}