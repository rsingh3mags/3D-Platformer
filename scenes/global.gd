extends Node

#how many coins collected
var coins_collected = 0 

#when pressed "esc" return to main menu.
func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
