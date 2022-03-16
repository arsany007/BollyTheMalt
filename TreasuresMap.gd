extends TileMap

#Signal to be recieved from Card stack
var signal_current_treasure

const Layer_None = 0
const Layer_Player_1 = 1
const Layer_Player_2 = 2
const Layer_Player_3 = 3
const Layer_Player_4 = 4
const Layer_Treasure = 5
const Layer_Ground = 6
	

func _on_PlayerKini_hit(collision_detected):
	
	if typeof(collision_detected.get_collider()) == typeof(TileMap) :
		
		var collider = collision_detected.get_collider() as TileMap

		var tileset = collider.get_tileset() 
		
		if collider.name == "TreasuresMap":
			
			var collider_layer = collider.get_collision_layer()	
			var collider_mask = collider.get_collision_mask()

			collider.set_collision_layer(Layer_None)
			collider.set_collision_mask(Layer_Treasure)
			
			var x=0
