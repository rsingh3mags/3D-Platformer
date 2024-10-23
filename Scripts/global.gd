extends Node
# save path variable
var save_path = "user://FastestTime.save"
# coins collected variable
var coins_collected = 0
# for adding time
var time: float = 0.0
# used for displaying minutes
var minutes: int = 0
# used for displaying seconds
var seconds: int =0
# used for displaying mili seconds
var msec: int = 0
# used for starting timer of the game at the start
var game_start = false
# used for storing variable time
var current_time = 0
# finall time used for path saving
var final_time = 0
# fastest time variable for saving
var fastest_time = 100000000


func _process(delta) -> void:
# when the game has started start timer
	if game_start == true:
		time += delta
		msec = fmod(time, 1) * 100
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60

# when a "escape" is pressed
func _input(event):
# return to main menu
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
# reset time
		reset_time()
		game_start=false
# When "r" is pressed (restart)
	if event.is_action_pressed("restart"):
# reset time
		time = 0
		minutes = 0
		seconds = 0
		msec = 0
		coins_collected = 0
# reset time function 
func reset_time():
	time = 0.0
	minutes = 0
	seconds = 0
	msec = 0
	coins_collected = 0 

# saving best time function
func save_score():
# when someone beats fastest time.
# save new fastest time.
	if Global.final_time < Global.fastest_time:
		Global.fastest_time = Global.final_time
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.fastest_time)
	
# loading score function
func load_score():
# read the fastest time. 
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		Global.fastest_time = file.get_var()
	else:
		Global.fastest_time = 10000000
