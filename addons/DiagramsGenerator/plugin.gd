tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	print("_enter_tree!")
	# Load the  doc_dock scene and instance it.
	var doc_dock = load("res://addons/DiagramsGenerator/Doc_Dock_Control.tscn").instance()
	doc_dock.get_node("Doc_Dock_Button").connect("pressed",self,"_on_button_pressed")
	add_child(doc_dock)
	
	
func _on_button_pressed():
	var parsed_files = Collect_ModelFiles("res://")
	Parse_ModelFiles(parsed_files)
	
	#TODO --- link all nodes !!!!!!
						
	pass

func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the doc_dock.
	print("_exit_tree!")



func Collect_ModelFiles(scan_dir : String) -> Array:
	var my_files : Array = []
	var dir := Directory.new()
	if dir.open(scan_dir) != OK:
		printerr("Warning: could not open directory: ", scan_dir)
		return []

	if dir.list_dir_begin(true, true) != OK:
		printerr("Warning: could not list contents of: ", scan_dir)
		return []

	var file_name := dir.get_next()
	while file_name != "":
		if not file_name.begins_with(".") and not file_name==("addons"):
			if dir.current_is_dir():
				my_files += Collect_ModelFiles(dir.get_current_dir() + "/" + file_name)
			else:
				if file_name.ends_with(".tscn") or file_name.ends_with(".gd"):
					my_files.append(dir.get_current_dir() + "/" + file_name)

		file_name = dir.get_next()

	return my_files



func Parse_ModelFiles(parsed_files):
	var parsed_lines = {"Nodes": [],"Signals": []}
	for file_name in parsed_files:
		var parsed_file = File.new()
		var valid_nodes_info = []
				
		parsed_file.open(file_name, File.READ)
			
		while not parsed_file.eof_reached(): # iterate through all lines until the end of file is reached
			var line = parsed_file.get_line()

			if line.begins_with("[node name="):
				var line_info
				line_info = Get_LineInfo(line,"Node")
				if line_info:

					valid_nodes_info.append(line_info)

			elif line.begins_with("[connection signal="):
				#parsed_lines["Signals"].append(line)
				# TODO ---- handle signals in get info !!!!!!
				pass

		parsed_lines["Nodes"].append_array(Clean_NodeInfo(valid_nodes_info))
		parsed_file.close()
		
	#print(parsed_lines)
		
func Clean_NodeInfo(nodes_info : Array) -> Array:
	
	var parent_of_nodes = ""
	
	for node in nodes_info:
		if node["parent"] == "":
			parent_of_nodes = node["name"]
		
		elif node["parent"] == "." and parent_of_nodes != "":
			node["parent"] = parent_of_nodes
		
	
	return nodes_info

func Get_LineInfo(line : String, type : String) -> Dictionary:

	if type == "Node":
		var node_infos = {"name":"","type":"","parent":""}
		var regex = RegEx.new()
		regex.compile("node name=\"(.*?)\" type=\"(.*?)\"( parent=\"(.*?)\")?")
		var result = regex.search(line)
		if result:
			node_infos["name"] = result.get_string(1)
			node_infos["type"] = result.get_string(2)
			node_infos["parent"] = result.get_string(4)			

			return node_infos
		
		else:
			var regex2 = RegEx.new()
			regex2.compile("node name=\"(.*?)\" parent=\"(.*?)\" instance=(ExtResource(.*))]")
			var result2 = regex2.search(line)

			if result2:
				node_infos["name"] = result2.get_string(1)
				node_infos["parent"] = result2.get_string(2)
				node_infos["type"] = result2.get_string(3)			
				
				return node_infos

	return {}
