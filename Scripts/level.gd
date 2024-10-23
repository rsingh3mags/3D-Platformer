extends Node3D
@onready var time: float = Global.time
@export var level_num = 0 
var save_path = "user://FastestTime.save"
#adding the coins once they are collected
# All the code that is needed for the timer to work

func _process(delta) -> void:
	$Timer/Minutes.text = "%02d:" % Global.minutes
	$Timer/Seconds.text = "%02d." % Global.seconds
	$Timer/Msecs.text = "%03d" % Global.msec
	Global.current_time += delta
	
	
func _ready():
	$HUD.level(level_num)
	set_coins_label()
	for coins in $Coins.get_children():
		coins.coins_collected.connect(_on_coins_collected)
		

#when coins collected
func _on_coins_collected():
	set_coins_label() 
	
	
func set_coins_label():
	$HUD.coins(Global.coins_collected)

func _on_door_player_entered(level):
	get_tree().call_deferred("change_scene_to_file", level)
