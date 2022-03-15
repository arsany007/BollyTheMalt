extends Area2D

var screen_size # Size of the game window.
var speed =400

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
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

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
