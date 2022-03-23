extends Node

onready var globals = get_node("../Globals")
onready var HUD = $HUD


var player1_score = 0
var player1_ice_poop = null
var remaining_keys = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	remaining_keys = globals.Icepoops.keys().size()
	player1_ice_poop = choose_player_ice_poop()
	HUD.update_selected_ice_poop(player1_ice_poop)

func _on_PlayerKini_ice_poop_hit(collided_ice_poop):
	var collided_ice_poop_node2d = collided_ice_poop as Node2D
	var collided_ice_poop_name = collided_ice_poop_node2d.get_node("Sprite").texture.resource_path
	if(collided_ice_poop_name == ("res://art/" + player1_ice_poop)):
		player1_score += 1
		globals.Icepoops[player1_ice_poop] = globals.ice_poop_state_E.DETECTED_E
		collided_ice_poop.queue_free()
		player1_ice_poop = choose_player_ice_poop()
		if player1_ice_poop != null:
			HUD.update_score(player1_score)
			HUD.update_selected_ice_poop(player1_ice_poop)
		else:
			HUD.game_over()

func choose_player_ice_poop():
	var player = null
	var ice_poop_keys = globals.Icepoops.keys()
	var key_found = false
	while (!key_found && remaining_keys >0):
		var selected_ice_poop_key = ice_poop_keys[randi() % ice_poop_keys.size()]
		if (globals.Icepoops[selected_ice_poop_key] == globals.ice_poop_state_E.NOT_DETECTED_E):
			player = selected_ice_poop_key
			globals.Icepoops[selected_ice_poop_key] = globals.ice_poop_state_E.IN_DETECTION_E
			remaining_keys -=1
			key_found = true
			
	return player
