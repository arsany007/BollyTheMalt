extends Node2D

onready var globals = get_node("../Globals")

signal ice_cream_hit

func _on_Area2D_body_entered(body):
	if body.is_class("KinematicBody2D"): #bolly hit the treasure
		var kinematic_body = body as KinematicBody2D
		
		#var icecream_hit_path = $Sprite.texture.resource_path
		globals.player1_score += 1
		
		emit_signal("ice_cream_hit")
		queue_free()
