extends Node2D

onready var globals = get_node("Globals")
onready var Map = $TileMap
onready var HUD = $HUD


const N = 1
const E = 2
const S = 4
const W = 8

var cell_walls = {Vector2(0, -1): N, Vector2(1, 0): E, 
				  Vector2(0, 1): S, Vector2(-1, 0): W}

func _ready():
	randomize()
	Map.cell_size = Vector2(globals.tile_size,globals.tile_size)
	make_maze()
	
func check_neighbors(cell, unvisited):
	# returns an array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []
	# fill the map with solid tiles
	Map.clear()
	for x in range(globals.maze_width):
		for y in range(globals.maze_height):
			unvisited.append(Vector2(x, y))
			Map.set_cellv(Vector2(x, y), N|E|S|W)
	var current = Vector2(0, 0)
	unvisited.erase(current)
	# execute recursive backtracker algorithm
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			# remove walls from *both* cells
			var dir = next - current
			var current_walls = Map.get_cellv(current) - cell_walls[dir]
			var next_walls = Map.get_cellv(next) - cell_walls[-dir]
			Map.set_cellv(current, current_walls)
			Map.set_cellv(next, next_walls)
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
		#yield(get_tree(), 'idle_frame')
	#RandomRotate()
	AddIcePoops()

func AddIcePoops():
	
	for Icepoop_key in globals.Icepoops.keys():	
		var Icepoop_node = preload("res://IcePoop.tscn")
		var Icepoop_instance = Icepoop_node.instance()
		Icepoop_instance.get_node("Sprite").texture = load("res://art/" + Icepoop_key)
		
		var rand_x = globals.tile_size* rand_range(1,globals.maze_width-1)
		var rand_y = globals.tile_size* rand_range(1,globals.maze_height-1)
		Icepoop_instance.position = Vector2(globals.center_cell_init+ rand_x, globals.center_cell_init+ rand_y )
		
		add_child(Icepoop_instance)

		
		#globals.Icepoops[Icepoop_key] = Icepoop_instance.position


func RandomRotate():
	for x in range(1,globals.maze_width-2): # disable rotating corners (player's init pos)
		for y in range(1,globals.maze_height-2):
			Rotate(Vector2(x, y),rand_range(0,3))


func Rotate(cell, num_rotate):
	
	var player_cell = position_to_cell($PlayerKini.position)
	
	if(player_cell != cell):
		var i = num_rotate
		while i >= num_rotate:
			var cell_index = Map.get_cellv(cell)
			var new_cell = RightRotate(cell_index)
			Map.set_cellv(cell, new_cell)
			i = i-1

func RightRotate(n):
	return (n >> 1)|(n << (4 - 1)) & 0xF


func position_to_cell(position):
	var cell_x = floor( position.x / globals.tile_size )
	var cell_y = floor( position.y / globals.tile_size )
	return Vector2(cell_x,cell_y)
	
	
func _on_TileMap_signal_rotate_cell(cell):
	Rotate(cell, 1)


func _on_PlayerKini_ice_poop_hit(score):
	HUD.update_score(score)
