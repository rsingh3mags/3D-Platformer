extends Node

var coins_collected = 0 

func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
