extends Node

var best_time: float = INF

func _ready():
	var file = File.new()
		if file.open("user://test_file.txt", File.WRITE) == OK:
			file.store_string("Hello, Godot!")
			file.close()


func save_best_time(new_time: float) -> void:
	if new_time < best_time:
		best_time = new_time
		var file = File.new()  # Create a new File instance
		if file.open("user://", File.WRITE) == OK:
			file.store_float(best_time)
			file.close()

func load_best_time() -> void:
	var file = File.new()  # Create a new File instance
	if file.open("user://best_time.save", File.READ) == OK:
		best_time = file.get_float()
		file.close()
