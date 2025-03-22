obj_name = object_get_name(object_index)
RunGMLI = new RunGML_Interpreter(obj_name);
RunGMLI.parent = id;
event_dict = {}

run_event = function(_event) {
	if struct_exists(event_dict, _event){
		var _event_l = struct_get(event_dict, _event)
		if debug show_debug_message(@"RunGML:O:{0}.run_event({1})", object_get_name(object_index), _event);
		var _event_copy = json_parse(json_stringify(_event_l));
		RunGMLI.run(_event_copy);
	}
}

run_event("create");