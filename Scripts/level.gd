extends Node3D
# Used for displaying time
@onready var time: float = Global.time
# Export level number used for changes scenes
@export var level_num = 0 
# Saving path variable

# All the code that is needed for the timer to work
func _process(delta) -> void:
	$Timer/Minutes.text = "%02d:" % Global.minutes
	$Timer/Seconds.text = "%02d." % Global.seconds
	$Timer/Msecs.text = "%03d" % Global.msec
	Global.current_time += delta

# Called when the node enters the scene tree for the first time
func _ready():
	$HUD.level(level_num)
	set_coins_label()
	for coins in $Coins.get_children():
		coins.coins_collected.connect(_on_coins_collected)


# When coins collected
func _on_coins_collected():
	set_coins_label() 


# When coin is collected put it on display
func set_coins_label():
	$HUD.coins(Global.coins_collected)


# When player enters the foor it switches to the next scene
func _on_door_player_entered(level):
	get_tree().call_deferred("change_scene_to_file", level)
