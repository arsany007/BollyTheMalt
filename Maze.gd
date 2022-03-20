extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

const TREASURES_NUMBER = 3

var cell_walls = {Vector2(0, -1): N, Vector2(1, 0): E, 
				  Vector2(0, 1): S, Vector2(-1, 0): W}

const tile_size = 64  # tile size (in pixels)
const maze_width = 16  # width of map (in tiles)
const maze_height = 9  # height of map (in tiles)
const center_cell_init = tile_size/2

# get a reference to the map for convenience
onready var Map = $TileMap
onready var TreasuresMap = $TreasuresMaponready 
onready var Player1 = $Player

func _ready():
	randomize()
	Map.cell_size = Vector2(tile_size,tile_size)
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
	for x in range(maze_width):
		for y in range(maze_height):
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
	#AddTreasures()
	AddIcecreams()

func AddIcecreams():
	var icecream_node = null	
	var icecream_instance = null
	var init_pos_val = Vector2(0,0)
	var icecreams = {"blackberry.png":init_pos_val, "bubblegum.png":init_pos_val ,"cherry.png":init_pos_val ,
				"cola.png":init_pos_val ,"creamsoda.png":init_pos_val ,"lemon.png":init_pos_val 
				,"lime.png":init_pos_val ,"melon.png":init_pos_val ,"mojito.png":init_pos_val 
				,"orange.png":init_pos_val ,"passionfruit.png":init_pos_val ,"strawberry.png":init_pos_val}
				
	for icecream_key in icecreams.keys():	
		icecream_node = load("res://IceCream.tscn")
		icecream_instance = icecream_node.instance()
		#icecream_node.Sprite.texture = load("res://art/" + sprite_key)

		var rand_x = tile_size* rand_range(1,maze_width-1)
		var rand_y = tile_size* rand_range(1,maze_height-1)
		icecream_instance.position = Vector2(center_cell_init+ rand_x, center_cell_init+ rand_y )

		add_child(icecream_instance)
		
		icecreams[icecream_key] = icecream_instance.position
	
func AddTreasures():
	
	for i in TREASURES_NUMBER:
		var rand_x = rand_range(1,maze_width-1)
		var rand_y = rand_range(1,maze_height-1)
		
		TreasuresMap.set_cellv(Vector2(rand_x, rand_y ), i)
	

func RandomRotate():
	for x in range(1,maze_width-2): # disable rotating corners (player's init pos)
		for y in range(1,maze_height-2):
			Rotate(Vector2(x, y),rand_range(0,3))


func Rotate(cell, num_rotate):
	
	var player_cell = position_to_cell($PlayerKini.position)
	
	if(player_cell != cell):
		var i = num_rotate
		while i >= num_rotate:
			var cell_index = Map.get_cellv(cell)
			var new_cell = RightRotate(Map.get_cellv(cell))
			Map.set_cellv(cell, new_cell)
			i = i-1

func RightRotate(n):
	return (n >> 1)|(n << (4 - 1)) & 0xF


func _on_TileMap_signal_rotate_cell(cell):
	Rotate(cell, 1)

func position_to_cell(position):
	var cell_x = floor( position.x / tile_size )
	var cell_y = floor( position.y / tile_size )
	return Vector2(cell_x,cell_y)


