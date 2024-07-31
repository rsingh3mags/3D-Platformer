extends Node3D

#adding the coins once they are collected
func _ready():
	for coins in $Coins.get_children():
		coins.coins_collected.connect(_on_coins_collected)

#When player enters the door change to "level_2"
func _on_area_3d_body_entered(body):
	if body ==$Player:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_coins_collected():
	$HUD/CoinsLabel.text = "Coins: " +  str(Global.coins_collected)
