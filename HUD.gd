extends CanvasLayer

func update_score(score):
	$Score.text = str(score)
	
func update_selected_ice_poop(player1_ice_poop):
	$SelectedIcePoop.text = str(player1_ice_poop)
