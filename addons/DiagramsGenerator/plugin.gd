tool
extends EditorPlugin
# node_infos = {"name":"","type":"","parent":""}
# signal_infos = {"signal":"","from":"","to":"","method":""}
var parsed_lines = {"Nodes": [],"Signals": []}
var parent_of_nodes_in_file = ""
var md_file

func _enter_tree():
	# Initialization of the plugin goes here.
	parsed_lines = {"Nodes": [],"Signals": []}
	parent_of_nodes_in_file = ""
	# Load the  doc_dock scene and instance it.
	var doc_dock = load("res://addons/DiagramsGenerator/Doc_Dock_Control.tscn").instance()
	doc_dock.get_node("Doc_Dock_Button").connect("pressed",self,"_on_button_pressed")
	add_child(doc_dock)


func _on_button_pressed():
	var parsed_files = Collect_ModelFiles("res://")
	Parse_ModelFiles(parsed_files)
	#Draw_MarkdownFile("Joka","Arsany","Node","many_kisses")
	#Draw_MarkdownFile("Arsany","Joka","Signal","many_many_many_kisses")
	Draw_Nodes()
	Draw_Signals()
	Close_MarkdownFile()


func _exit_tree():
	parsed_lines = {"Nodes": [],"Signals": []}
	parent_of_nodes_in_file = ""
	pass


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
	for file_name in parsed_files:
		var parsed_file = File.new()
		var valid_nodes_info = []
		var valid_signals_info = []
				
		parsed_file.open(file_name, File.READ)
			
		while not parsed_file.eof_reached(): # iterate through all lines until the end of file is reached
			var line = parsed_file.get_line()

			if line.begins_with("[node name="):
				var line_info = Get_LineInfo(line,"Node")
				if line_info:
					valid_nodes_info.append(line_info)

			elif line.begins_with("[connection signal="):
				var line_info = Get_LineInfo(line,"Signal")
				if line_info:
					valid_signals_info.append(line_info)

		# Node shall be handled before signals, such that the parent_of_nodes_in_file will get a value
		parsed_lines["Nodes"].append_array(Clean_Info(valid_nodes_info,"Node"))
		parsed_lines["Signals"].append_array(Clean_Info(valid_signals_info,"Signal"))
		parent_of_nodes_in_file = ""
		parsed_file.close()
		
	#print(parsed_lines)

func Draw_Nodes():
	#TODO: Link Dynamic nodes "add_child ---> .tscn"
	for node in parsed_lines["Nodes"]:
		Draw_MarkdownFile(node["parent"],node["name"],"Node","child")	


func Draw_Signals():
	for signal_var in parsed_lines["Signals"]:
		Draw_MarkdownFile(signal_var["from"],signal_var["to"],"Signal",signal_var["method"])	


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
	
	elif  type == "Signal":
		var signal_infos = {"signal":"","from":"","to":"","method":""}
		var regex = RegEx.new()
		regex.compile("connection signal=\"(.*?)\" from=\"(.*?)\" to=\"(.*?)\" method=\"(.*?)\"")
		var result = regex.search(line)
		if result:
			signal_infos["signal"] = result.get_string(1)
			signal_infos["from"] = result.get_string(2)
			signal_infos["to"] = result.get_string(3)
			signal_infos["method"] = result.get_string(4)
			return signal_infos
		
	return {}


func Clean_Info(info : Array, type : String) -> Array:
	
	if type == "Node":
		for node in info:
			if node["parent"] == "":
				parent_of_nodes_in_file = node["name"]
			elif node["parent"] == "." and parent_of_nodes_in_file != "":
				node["parent"] = parent_of_nodes_in_file
			
			node["parent"] = node["parent"].rsplit("/")[-1]
	
	elif  type == "Signal":
		for signal_var in info:
			if signal_var["to"] == "." and parent_of_nodes_in_file != "":
				signal_var["to"] = parent_of_nodes_in_file
			if signal_var["from"] == "." and parent_of_nodes_in_file != "":
				signal_var["from"] = parent_of_nodes_in_file
				
			signal_var["from"] = signal_var["from"].rsplit("/")[-1]
			signal_var["to"] = signal_var["to"].rsplit("/")[-1]

	return info

func Create_MarkdownFile():
	md_file = File.new()
	md_file.open("res://ModelDocumentation.md", File.WRITE_READ)
	md_file.store_string("Limitation: \n")		
	md_file.store_string("Nodes have to have unique names \n")	
	md_file.store_string("```mermaid \n flowchart LR \n ")
	
func Draw_MarkdownFile(from:String, to:String, arrow:String, text:String):
	if from and to:
		if arrow == "Node":
			arrow = "--->"
		else:
			arrow =  "-.->"
		var content = from + arrow + " |" + text + "| " + to
		if not md_file or  not md_file.is_open() : Create_MarkdownFile()
		md_file.seek_end()
		md_file.store_string("\n")
		md_file.store_string(content)

func Close_MarkdownFile():
	md_file.seek_end()
	md_file.store_string("\n```")
	md_file.close()
	parsed_lines = {"Nodes": [],"Signals": []}
	parent_of_nodes_in_file = ""
