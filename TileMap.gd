extends TileMap
signal signal_rotate_cell(cell)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var clicked_cell = world_to_map(event.position)
			emit_signal("signal_rotate_cell",clicked_cell)


