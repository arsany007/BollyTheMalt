extends Node

onready var HUD = $HUD
var player1_score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerKini_ice_poop_hit(collided_ice_poop):
	var collided_ice_poop_node2d = collided_ice_poop as Node2D
	var collided_ice_poop_name = collided_ice_poop_node2d.get_node("Sprite").texture.resource_path
	if(collided_ice_poop_name == ("res://art/" + "blackberry.png")):
		player1_score += 1
		collided_ice_poop.queue_free()
		HUD.update_score(player1_score)
