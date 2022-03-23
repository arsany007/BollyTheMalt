extends Node2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "PlayerKini":
		if body.add_ice_poop(self):
			queue_free()
