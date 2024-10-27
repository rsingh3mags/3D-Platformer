extends Node
# Save path variable
var save_path = "user://goattimes.save"
# Coins collected variable
var coins_collected = 0
# For adding time
var time: float = 0.0
# Used for displaying minutes
var minutes: int = 0
# Used for displaying seconds
var seconds: int =0
# Used for displaying mili seconds
var msec: int = 0
# Used for starting timer of the game at the start
var game_start = false
# Used for storing variable time
var current_time = 0
# Final time used for path saving
var final_time = 0
# Fastest time variable for saving
var fastest_time = 100000000


func _process(delta) -> void:
# When the game has started start timer
	if game_start == true:
		time += delta
		msec = fmod(time, 1) * 100
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60


# When a "escape" is pressed
func _input(event):
# return to main menu
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
# Reset time
		reset_time()
		game_start=false

# When "r" is pressed (restart)
	if event.is_action_pressed("restart"):
		reset_time()


# Reset time function 
func reset_time():
	time = 0.0
	minutes = 0
	seconds = 0
	msec = 0
	coins_collected = 0 


# Saving best time function
func save_score():
# When someone beats fastest time.
# Save new fastest time.
	if final_time < fastest_time:
		fastest_time = final_time
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(fastest_time)


# Loading score function
# Read the fastest time. 
func load_score():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		fastest_time = file.get_var()
	else:
		fastest_time = 10000000
