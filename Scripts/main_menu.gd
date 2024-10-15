extends Node2D

const CAMERA_ROTATE_SPEED = 30
@onready var world_camera = $Camera3D

#When start button pressed change the scene to "level_1"
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

#fullscreen when pressed
func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN )
