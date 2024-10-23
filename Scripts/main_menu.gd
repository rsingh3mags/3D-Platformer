extends Node2D

#When start button pressed change the scene to "level_1"
func _on_start_button_pressed():
	Global.game_start=true
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	Global.coins_collected = 0
	Global.set_process(true)
	Global.load_score()
	
#fullscreen when pressed
func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN )

# when quit is pressed the game closes
func _on_quit_button_pressed():
	get_tree().quit()
# 
# when the game is started load the score
func _ready():
	Global.load_score()

# when controls is pressed it changes scene
func _on_controls_pressed():
	get_tree().change_scene_to_file("res://scenes/Controls.tscn")
