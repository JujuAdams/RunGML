function RunGML_DefineAliases(_wipe=true) {
	if _wipe global.RunGML_Aliases = {}
	
	RunGML_alias("a", "array");
	// Remember that "e" is reserved for the mathematical constant
	RunGML_alias("g", "global");
	RunGML_alias("i", "inst");
	RunGML_alias("l", "list");
	RunGML_alias("o", "object");
	RunGML_alias("p", "parent");
	RunGML_alias("q", "quit");
	RunGML_alias("r", "reference");
	RunGML_alias("rp", "reference_parent");
	RunGML_alias("s", "struct");
	RunGML_alias("t", "this");
	RunGML_alias("v", "var");
	RunGML_alias("str", "string");
	RunGML_alias("multiply", "mult");
	RunGML_alias("subtract", "sub");
	RunGML_alias("divide", "div");
	
	// Constants
	RunGML_alias("RunGML_Version", "version")
	RunGML_alias("GM_version", "gm_version")
	RunGML_alias("GM_build_type", "gm_build_type")
	RunGML_alias("GM_build_date", "gm_build_date")
	RunGML_alias("GM_runtime_version", "gm_runtime_version")
	RunGML_alias("True", "true");
	RunGML_alias("False", "false");
	RunGML_alias("NaN", "nan");
}