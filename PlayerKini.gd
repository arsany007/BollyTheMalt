extends KinematicBody2D

onready var globals = get_node("../Globals")

signal ice_poop_hit(collided_ice_poop)

var screen_size # Size of the game window.
var speed =400

var score=0

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.animation = "right"
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.animation = "left"
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite.animation = "down"
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		$AnimatedSprite.animation = "up"
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	move_and_collide( velocity * delta )

	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	scale.x = globals.player1_Size
	scale.y = globals.player1_Size
	
	
func hit_ice_poop(collided_ice_poop): 
	#var collided_ice_poop_node2d = collided_ice_poop as Node2D
	#var collided_ice_poop_name = collided_ice_poop_node2d.get_node("Sprite").texture.resource_path
	
	#score += 1
	emit_signal("ice_poop_hit",collided_ice_poop)
	return true
