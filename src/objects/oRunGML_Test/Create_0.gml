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
		["r", "cat", 0, 1]
	]))
	
	//run(["pass",
	//	["v", 0, 1],
	//	["v", 1, 42],
	//	["while", {
	//		"check": ["r", "lt", 0, 1],
	//		"do": ["pass",
	//			["v", 0, ["add", 5, ["v", 0]]],
	//			["r", "print", 0]
	//		]
	//	}]
	//])
	
	// Run a program from a file
	run(["runfile", "RunGML/programs/examples/hello.txt"]);

	// Create an object from a file
	run(["runfile", "RunGML/programs/examples/object.txt"])

	// Run an example program
	run(["example", "math"]);

	//// Display a frame counter
	//run(["runfile", "RunGML/examples/counter.txt"]);
	
	// Create a clock
	run(["example", "clock"]);
	
	// Create a bouncer
	run(["example", "bounce"]);
}