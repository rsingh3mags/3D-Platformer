extends Node3D

@export var level_num = 0 

#adding the coins once they are collected
func _ready():
	print("level " + str(level_num) + " ready!")
	for coins in $Coins.get_children():
		coins.coins_collected.connect(_on_coins_collected)

#when coins collected
func _on_coins_collected():
	$HUD/CoinsLabel.text = "Coins: " +  str(Global.coins_collected)
	
func _on_door_player_entered(level):
	get_tree().change_scene_to_file(level)
