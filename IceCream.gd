extends Node2D

const Layer_None = 0
const Layer_Player_1 = 1
const Layer_Player_2 = 2
const Layer_Player_3 = 3
const Layer_Player_4 = 4
const Layer_Treasure = 5
const Layer_Ground = 6


const tile_size = 64  # tile size (in pixels)
const maze_width = 16  # width of map (in tiles)
const maze_height = 9  # height of map (in tiles)
const center_cell_init = tile_size/2


var sprite = null
var init_pos_val = Vector2(0,0)
var sprites = {"blackberry.png":init_pos_val, "bubblegum.png":init_pos_val ,"cherry.png":init_pos_val ,
				"cola.png":init_pos_val ,"creamsoda.png":init_pos_val ,"lemon.png":init_pos_val 
				,"lime.png":init_pos_val ,"melon.png":init_pos_val ,"mojito.png":init_pos_val 
				,"orange.png":init_pos_val ,"passionfruit.png":init_pos_val ,"strawberry.png":init_pos_val}
		

func _on_Area2D_body_entered(body):
	if typeof(body) == typeof(KinematicBody2D): #bolly hit the treasure
		var kinematic_body = body as KinematicBody2D
		
		for sprite_key in sprites.keys():	
			if kinematic_body.position.x > sprites[sprite_key].x - center_cell_init && kinematic_body.position.x < sprites[sprite_key].x + center_cell_init:
					if kinematic_body.position.y > sprites[sprite_key].y - center_cell_init && kinematic_body.position.y < sprites[sprite_key].y + center_cell_init:
						var x=0
	pass
		

		
