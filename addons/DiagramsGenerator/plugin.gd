tool
extends EditorPlugin


# A class member to hold the doc_dock during the plugin life cycle.
var  doc_dock


func _enter_tree():
	# Initialization of the plugin goes here.
	# Load the  doc_dock scene and instance it.
	doc_dock = preload("res://addons/DiagramsGenerator/Doc_Dock_Control.tscn").instance()
	print("_enter_tree!")
	# Add the loaded scene to the doc_docks.
	add_control_to_dock(DOCK_SLOT_RIGHT_UR, doc_dock)
	# Note that LEFT_UL means the left of the editor, upper-left doc_dock.


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the doc_dock.
	print("_exit_tree!")
	remove_control_from_docks(doc_dock)
	# Erase the control from the memory.
	doc_dock.free()

