extends TileMap

#Signal to be recieved from Card stack
var signal_current_treasure



func _on_PlayerKini_hit(collision_detected):
	var collider = collision_detected.get_collider()
	if collider.name == "TreasuresMap":
		var x=0
