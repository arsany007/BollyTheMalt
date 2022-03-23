extends Node

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


enum ice_poop_state_E{
	NOT_DETECTED_E = 0,
	IN_DETECTION_E  = 1,
	DETECTED_E  = 2}
	
var Icepoops = {"blackberry.png":ice_poop_state_E.NOT_DETECTED_E, "bubblegum.png":ice_poop_state_E.NOT_DETECTED_E ,"cherry.png":ice_poop_state_E.NOT_DETECTED_E ,
				"cola.png":ice_poop_state_E.NOT_DETECTED_E ,"creamsoda.png":ice_poop_state_E.NOT_DETECTED_E ,"lemon.png":ice_poop_state_E.NOT_DETECTED_E 
				,"lime.png":ice_poop_state_E.NOT_DETECTED_E ,"melon.png":ice_poop_state_E.NOT_DETECTED_E ,"mojito.png":ice_poop_state_E.NOT_DETECTED_E 
				,"orange.png":ice_poop_state_E.NOT_DETECTED_E ,"passionfruit.png":ice_poop_state_E.NOT_DETECTED_E ,"strawberry.png":ice_poop_state_E.NOT_DETECTED_E}



