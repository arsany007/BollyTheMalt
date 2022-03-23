extends CanvasLayer

func new_game():
	pass
	
func update_score(score):
	$Score.text = str(score)
	
func update_selected_ice_poop(player1_ice_poop):
	$SelectedIcePoopLabel.text = str(player1_ice_poop)	
	$SelectedIcePoop.texture = load("res://art/" + player1_ice_poop)

func game_over():
	pass
