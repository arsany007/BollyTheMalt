extends Node2D

onready var globals = get_node("../Globals")

var sprite = null
var init_pos_val = Vector2(0,0)
var sprites = {"blackberry.png":init_pos_val, "bubblegum.png":init_pos_val ,"cherry.png":init_pos_val ,
				"cola.png":init_pos_val ,"creamsoda.png":init_pos_val ,"lemon.png":init_pos_val 
				,"lime.png":init_pos_val ,"melon.png":init_pos_val ,"mojito.png":init_pos_val 
				,"orange.png":init_pos_val ,"passionfruit.png":init_pos_val ,"strawberry.png":init_pos_val}
		
func _on_Area2D_body_entered(body):
	if body.is_class("KinematicBody2D"): #bolly hit the treasure
		var kinematic_body = body as KinematicBody2D
		for sprite_key in sprites.keys():	
			if kinematic_body.position.x > sprites[sprite_key].x - globals.center_cell_init and \
			   kinematic_body.position.x < sprites[sprite_key].x + globals.center_cell_init:
					if kinematic_body.position.y > sprites[sprite_key].y - globals.center_cell_init and \
					   kinematic_body.position.y < sprites[sprite_key].y + globals.center_cell_init:
						var x=0
	pass
		

		
