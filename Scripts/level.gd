extends Node3D

@export var level_num = 0 

#adding the coins once they are collected
func _input(InputEvent):
	if  Input.is_action_just_pressed("restart"):
		Global.coins_collected = 0
		get_tree().call_deferred("reload_current_scene")

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
	Global.coins_collected = 0
