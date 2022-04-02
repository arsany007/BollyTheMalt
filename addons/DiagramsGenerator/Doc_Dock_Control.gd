extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Button_ready")
	pass # Replace with function body.



func _on_Doc_Dock_Button_pressed():
	Collect_ModelFiles()
	Parse_ModelFiles()
	pass # Replace with function body.



func Collect_ModelFiles():
	var path = "res://"
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()
	print(files)
	return files



func Parse_ModelFiles():
	pass
	


func _on_Doc_Dock_Button_button_down():
	print("HIIIIII")
	pass # Replace with function body.
