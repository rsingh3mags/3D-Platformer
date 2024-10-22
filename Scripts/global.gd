extends Node
var save_path = "user://besttime.save"
#how many coins collected
var coins_collected = 0
var time: float = 0.0
var minutes: int = 0
var seconds: int =0
var msec: int = 0
var game_start = false
var current_time = 0
var final_time = 0
var fastest_time = 100000000

func _process(delta) -> void:
	if game_start == true:
		time += delta
		msec = fmod(time, 1) * 100
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60
	
#when pressed "esc" return to main menu.
func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
		time = 0
		minutes = 0
		seconds = 0
		msec = 0
		coins_collected = 0
		game_start=false
		
	if event.is_action_pressed("restart"):
		time = 0
		minutes = 0
		seconds = 0
		msec = 0
		coins_collected = 0

func reset_time():
	time = 0.0
	minutes = 0
	seconds = 0
	msec = 0
	coins_collected = 0 

func save_score():
	if Global.final_time < Global.fastest_time:
		Global.fastest_time = Global.final_time
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.fastest_time)

func load_score():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		Global.fastest_time = file.get_var()
	else:
		Global.fastest_time = 10000000
