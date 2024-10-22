extends Node2D
# level num var
@export var level_num = 0

func _ready():
# hide the buttons after the player presses play again.
	if !OS.has_feature("pc"):
		$Options/Fullscreen.hide()
		$Options/Quit.hide() 
	Global.set_process(false)
	$Minutes.text = "%02d:" % Global.minutes
	$Seconds.text = "%02d." % Global.seconds 
	$Msecs.text = "%03d" % Global.msec
	
	
# When the player presses start level 1 starts playing.
func _on_replay_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
	Global.time = 0
	Global.minutes = 0
	Global.seconds = 0
	Global.msec = 0
	Global.coins_collected = 0
	
# Function for fullscreening the game when player presses Fullscreen button.
func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN )

# Quit game when the player presses quit.
func _on_quit_button_pressed():
	get_tree().quit()

