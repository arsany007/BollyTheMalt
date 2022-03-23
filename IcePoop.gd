extends Node2D

signal poop_hit

onready var globals = get_node("../Globals")

func _on_Area2D_body_entered(body):
	globals.player1_score += 1
	emit_signal("poop_hit")
