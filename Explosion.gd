extends Node

signal HoleOpen

func Player_in_the_hole():
	emit_signal("HoleOpen")
