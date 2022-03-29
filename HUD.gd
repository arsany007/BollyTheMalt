extends CanvasLayer

signal New_Game
signal Game_Over

func _ready():
	$GameOver.hide()
	
func new_game():
	$Button.hide()
	$GameOver.hide()
	
	
func update_score(score):
	$Score.text = str(score)
	
func update_selected_ice_poop(player1_ice_poop):
	$SelectedIcePoopLabel.text = str(player1_ice_poop)	
	$SelectedIcePoop.texture = load("res://art/" + player1_ice_poop)

func game_over():
	$GameOver.show()
	$AnimationPlayer.play("GameOverAnimi")
	$Button.show()
	emit_signal("Game_Over")

func startAnimationDone():
	$GameOver.hide()
	
func _on_Button_pressed():
	new_game()
	emit_signal("New_Game")


func _on_Button2_pressed():
	game_over()
