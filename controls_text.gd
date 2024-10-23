extends Node2D


# When this button is pressed player returns to main menu
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
