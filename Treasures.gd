extends Node2D

const Layer_None = 0
const Layer_Player_1 = 1
const Layer_Player_2 = 2
const Layer_Player_3 = 3
const Layer_Player_4 = 4
const Layer_Treasure = 5
const Layer_Ground = 6

#var sprite = null;
const sprites = [ "treasure1.png", "treasure2.png",
		"treasure3.png"]
		
		
func _ready():
	#sprite = Sprite.new()
	#sprite.texture = load("res://art/" + sprites[randi()%sprites.size()])
	#add_child(sprite)
	pass


func _on_Area2D_body_entered(body):
	if typeof(body) == typeof(KinematicBody2D): #bolly hit the treasure
		var kinematic_body = body as KinematicBody2D
		kinematic_body.get

		
